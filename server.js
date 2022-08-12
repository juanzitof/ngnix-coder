import "dotenv/config";
import express, { json, urlencoded } from "express";
import session from "express-session";
import cookieParser from "cookie-parser";
import { Server as HttpServer } from "http";
import { Server as IOServer } from "socket.io";
import cors from "cors";
import path from "path";
import { yargObj } from "./utils/yargs.js";
import { fileURLToPath } from "url";
import MongoStore from "connect-mongo";
import moment from "moment";
import { config } from "./config/index.js";
import { mongoMessages } from "./containers/MongoMessageContainer.js";
import authRouter from "./auth/auth.js";
import { cartRouter } from "./routes/cartsRouter.js";
import { productsRouter } from "./routes/productsRouter.js";
import { webRouter } from "./routes/webRouter.js";
import { registerRouter } from "./routes/userRouter.js";
import { loginRouter } from "./routes/userRouter.js";
import normalizer from "./normalizr/normalizr.js";
import { infoRouter } from "./routes/infoRouter.js";
import { randomRouter } from "./routes/randomRouter.js";
import cluster from "cluster";
import os from "os";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);


const app = express();
const httpServer = new HttpServer(app);
const io = new IOServer(httpServer);


io.on("connection", async (socket) => {
	console.log("Nuevo cliente conectado!");

	socket.emit("messages", normalizer(await mongoMessages.getAll()));

	socket.on("message", async (message) => {
		const { author, text } = message;
		const newMessage = {
			author,
			text,
			fecha: moment(new Date()).format("DD/MM/YYY HH:mm:ss"),
		};

		await mongoMessages.save({
			author: newMessage.author,
			text: newMessage.text,
			fecha: newMessage.fecha,
		});
		io.sockets.emit("message", newMessage);
	});
});


app.use(json());
app.use(cookieParser());
app.use(urlencoded({ extended: true }));
app.use(express.static(__dirname + "/public"));
app.use(cors(`${config.cors}`));

app.set("view engine", "ejs");


app.use(
	session({
		store: MongoStore.create({
			mongoUrl: config.mongodb.url,
			mongoOptions: {
				useNewUrlParser: true,
				useUnifiedTopology: true,
			},
		}),
		secret: "coder",
		resave: false,
		saveUninitialized: false,
		cookie: {
			maxAge: 60000,
		},
	})
);

app.use("/register", registerRouter);
app.use("/login", loginRouter);
app.use("/api/productos", productsRouter);
app.use("/api/carrito", cartRouter);
app.use("/info", infoRouter);
app.use("/api/randoms", randomRouter);
app.use("/", webRouter);

const numCPUs = os.cpus().length;

const PORT = process.argv[2] || 8080;
const mode = process.argv[3]?.toUpperCase() || "FORK";

if (mode === "FORK") {
	const server = httpServer.listen(PORT, () => {
		console.log(
			`Server is up in port http://localhost:${PORT} || Worker ${process.pid} started!`
		);
	});
	server.on("error", (error) => console.log(`Server error: ${error}`));
	process.on("exit", (code) => console.log(`Exit code: ${code}`));
}

if (mode === "CLUSTER") {
	if (cluster.isPrimary) {
		console.log(`Master -> PID: ${process.pid}`);

		// Workers
		console.log("cpus..", numCPUs);
		for (let i = 0; i < numCPUs; i++) {
			cluster.fork();
		}
		cluster.on("exit", (worker, code, signal) => {
			console.log(`murió el subproceso ${worker.process.pid}`);
			cluster.fork();
		});
	} else {
		const server = httpServer.listen(PORT, () => {
			console.log(`Server on port ${PORT} || Worker ${process.pid} started!`);
		});

		server.on("error", (error) => console.log(`Server error: ${error}`));
		process.on("exit", (code) => console.log(`Exit code: ${code}`));
	}
}



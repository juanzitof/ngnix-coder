Changes with nginx 1.21.6                                        25 Jan 2022

    *) Bugfix: when using EPOLLEXCLUSIVE on Linux client connections were
       unevenly distributed among worker processes.

    *) Bugfix: nginx returned the "Connection: keep-alive" header line in
       responses during graceful shutdown of old worker processes.

    *) Bugfix: in the "ssl_session_ticket_key" when using TLSv1.3.


Changes with nginx 1.21.5                                        28 Dec 2021

    *) Change: now nginx is built with the PCRE2 library by default.

    *) Change: now nginx always uses sendfile(SF_NODISKIO) on FreeBSD.

    *) Feature: support for sendfile(SF_NOCACHE) on FreeBSD.

    *) Feature: the $ssl_curve variable.

    *) Bugfix: connections might hang when using HTTP/2 without SSL with the
       "sendfile" and "aio" directives.


Changes with nginx 1.21.4                                        02 Nov 2021

    *) Change: support for NPN instead of ALPN to establish HTTP/2
       connections has been removed.

    *) Change: now nginx rejects SSL connections if ALPN is used by the
       client, but no supported protocols can be negotiated.

    *) Change: the default value of the "sendfile_max_chunk" directive was
       changed to 2 megabytes.

    *) Feature: the "proxy_half_close" directive in the stream module.

    *) Feature: the "ssl_alpn" directive in the stream module.

    *) Feature: the $ssl_alpn_protocol variable.

    *) Feature: support for SSL_sendfile() when using OpenSSL 3.0.

    *) Feature: the "mp4_start_key_frame" directive in the
       ngx_http_mp4_module.
       Thanks to Tracey Jaquith.

    *) Bugfix: in the $content_length variable when using chunked transfer
       encoding.

    *) Bugfix: after receiving a response with incorrect length from a
       proxied backend nginx might nevertheless cache the connection.
       Thanks to Awdhesh Mathpal.

    *) Bugfix: invalid headers from backends were logged at the "info" level
       instead of "error"; the bug had appeared in 1.21.1.

    *) Bugfix: requests might hang when using HTTP/2 and the "aio_write"
       directive.


Changes with nginx 1.21.3                                        07 Sep 2021

    *) Change: optimization of client request body reading when using
       HTTP/2.

    *) Bugfix: in request body filters internal API when using HTTP/2 and
       buffering of the data being processed.


Changes with nginx 1.21.2                                        31 Aug 2021

    *) Change: now nginx rejects HTTP/1.0 requests with the
       "Transfer-Encoding" header line.

    *) Change: export ciphers are no longer supported.

    *) Feature: OpenSSL 3.0 compatibility.

    *) Feature: the "Auth-SSL-Protocol" and "Auth-SSL-Cipher" header lines
       are now passed to the mail proxy authentication server.
       Thanks to Rob Mueller.

    *) Feature: request body filters API now permits buffering of the data
       being processed.

    *) Bugfix: backend SSL connections in the stream module might hang after
       an SSL handshake.

    *) Bugfix: the security level, which is available in OpenSSL 1.1.0 or
       newer, did not affect loading of the server certificates when set
       with "@SECLEVEL=N" in the "ssl_ciphers" directive.

    *) Bugfix: SSL connections with gRPC backends might hang if select,
       poll, or /dev/poll methods were used.

    *) Bugfix: when using HTTP/2 client request body was always written to
       disk if the "Content-Length" header line was not present in the
       request.


Changes with nginx 1.21.1                                        06 Jul 2021

    *) Change: now nginx always returns an error for the CONNECT method.

    *) Change: now nginx always returns an error if both "Content-Length"
       and "Transfer-Encoding" header lines are present in the request.

    *) Change: now nginx always returns an error if spaces or control
       characters are used in the request line.

    *) Change: now nginx always returns an error if spaces or control
       characters are used in a header name.

    *) Change: now nginx always returns an error if spaces or control
       characters are used in the "Host" request header line.

    *) Change: optimization of configuration testing when using many
       listening sockets.

    *) Bugfix: nginx did not escape """, "<", ">", "\", "^", "`", "{", "|",
       and "}" characters when proxying with changed URI.

    *) Bugfix: SSL variables might be empty when used in logs; the bug had
       appeared in 1.19.5.

    *) Bugfix: keepalive connections with gRPC backends might not be closed
       after receiving a GOAWAY frame.

    *) Bugfix: reduced memory consumption for long-lived requests when
       proxying with more than 64 buffers.


Changes with nginx 1.21.0                                        25 May 2021

    *) Security: 1-byte memory overwrite might occur during DNS server
       response processing if the "resolver" directive was used, allowing an
       attacker who is able to forge UDP packets from the DNS server to
       cause worker process crash or, potentially, arbitrary code execution
       (CVE-2021-23017).

    *) Feature: variables support in the "proxy_ssl_certificate",
       "proxy_ssl_certificate_key" "grpc_ssl_certificate",
       "grpc_ssl_certificate_key", "uwsgi_ssl_certificate", and
       "uwsgi_ssl_certificate_key" directives.

    *) Feature: the "max_errors" directive in the mail proxy module.

    *) Feature: the mail proxy module supports POP3 and IMAP pipelining.

    *) Feature: the "fastopen" parameter of the "listen" directive in the
       stream module.
       Thanks to Anbang Wen.

    *) Bugfix: special characters were not escaped during automatic redirect
       with appended trailing slash.

    *) Bugfix: connections with clients in the mail proxy module might be
       closed unexpectedly when using SMTP pipelining.


Changes with nginx 1.19.10                                       13 Apr 2021

    *) Change: the default value of the "keepalive_requests" directive was
       changed to 1000.

    *) Feature: the "keepalive_time" directive.

    *) Feature: the $connection_time variable.

    *) Workaround: "gzip filter failed to use preallocated memory" alerts
       appeared in logs when using zlib-ng.


Changes with nginx 1.19.9                                        30 Mar 2021

    *) Bugfix: nginx could not be built with the mail proxy module, but
       without the ngx_mail_ssl_module; the bug had appeared in 1.19.8.

    *) Bugfix: "upstream sent response body larger than indicated content
       length" errors might occur when working with gRPC backends; the bug
       had appeared in 1.19.1.

    *) Bugfix: nginx might not close a connection till keepalive timeout
       expiration if the connection was closed by the client while
       discarding the request body.

    *) Bugfix: nginx might not detect that a connection was already closed
       by the client when waiting for auth_delay or limit_req delay, or when
       working with backends.

    *) Bugfix: in the eventport method.


Changes with nginx 1.19.8                                        09 Mar 2021

    *) Feature: flags in the "proxy_cookie_flags" directive can now contain
       variables.

    *) Feature: the "proxy_protocol" parameter of the "listen" directive,
       the "proxy_protocol" and "set_real_ip_from" directives in mail proxy.

    *) Bugfix: HTTP/2 connections were immediately closed when using
       "keepalive_timeout 0"; the bug had appeared in 1.19.7.

    *) Bugfix: some errors were logged as unknown if nginx was built with
       glibc 2.32.

    *) Bugfix: in the eventport method.


Changes with nginx 1.19.7                                        16 Feb 2021

    *) Change: connections handling in HTTP/2 has been changed to better
       match HTTP/1.x; the "http2_recv_timeout", "http2_idle_timeout", and
       "http2_max_requests" directives have been removed, the
       "keepalive_timeout" and "keepalive_requests" directives should be
       used instead.

    *) Change: the "http2_max_field_size" and "http2_max_header_size"
       directives have been removed, the "large_client_header_buffers"
       directive should be used instead.

    *) Feature: now, if free worker connections are exhausted, nginx starts
       closing not only keepalive connections, but also connections in
       lingering close.

    *) Bugfix: "zero size buf in output" alerts might appear in logs if an
       upstream server returned an incorrect response during unbuffered
       proxying; the bug had appeared in 1.19.1.

    *) Bugfix: HEAD requests were handled incorrectly if the "return"
       directive was used with the "image_filter" or "xslt_stylesheet"
       directives.

    *) Bugfix: in the "add_trailer" directive.


Changes with nginx 1.19.6                                        15 Dec 2020

    *) Bugfix: "no live upstreams" errors if a "server" inside "upstream"
       block was marked as "down".

    *) Bugfix: a segmentation fault might occur in a worker process if HTTPS
       was used; the bug had appeared in 1.19.5.

    *) Bugfix: nginx returned the 400 response on requests like
       "GET http://example.com?args HTTP/1.0".

    *) Bugfix: in the ngx_http_flv_module and ngx_http_mp4_module.
       Thanks to Chris Newton.


Changes with nginx 1.19.5                                        24 Nov 2020

    *) Feature: the -e switch.

    *) Feature: the same source files can now be specified in different
       modules while building addon modules.

    *) Bugfix: SSL shutdown did not work when lingering close was used.

    *) Bugfix: "upstream sent frame for closed stream" errors might occur
       when working with gRPC backends.

    *) Bugfix: in request body filters internal API.


Changes with nginx 1.19.4                                        27 Oct 2020

    *) Feature: the "ssl_conf_command", "proxy_ssl_conf_command",
       "grpc_ssl_conf_command", and "uwsgi_ssl_conf_command" directives.

    *) Feature: the "ssl_reject_handshake" directive.

    *) Feature: the "proxy_smtp_auth" directive in mail proxy.


Changes with nginx 1.19.3                                        29 Sep 2020

    *) Feature: the ngx_stream_set_module.

    *) Feature: the "proxy_cookie_flags" directive.

    *) Feature: the "userid_flags" directive.

    *) Bugfix: the "stale-if-error" cache control extension was erroneously
       applied if backend returned a response with status code 500, 502,
       503, 504, 403, 404, or 429.

    *) Bugfix: "[crit] cache file ... has too long header" messages might
       appear in logs if caching was used and the backend returned responses
       with the "Vary" header line.

    *) Workaround: "[crit] SSL_write() failed" messages might appear in logs
       when using OpenSSL 1.1.1.

    *) Bugfix: "SSL_shutdown() failed (SSL: ... bad write retry)" messages
       might appear in logs; the bug had appeared in 1.19.2.

    *) Bugfix: a segmentation fault might occur in a worker process when
       using HTTP/2 if errors with code 400 were redirected to a proxied
       location using the "error_page" directive.

    *) Bugfix: socket leak when using HTTP/2 and subrequests in the njs
       module.


Changes with nginx 1.19.2                                        11 Aug 2020

    *) Change: now nginx starts closing keepalive connections before all
       free worker connections are exhausted, and logs a warning about this
       to the error log.

    *) Change: optimization of client request body reading when using
       chunked transfer encoding.

    *) Bugfix: memory leak if the "ssl_ocsp" directive was used.

    *) Bugfix: "zero size buf in output" alerts might appear in logs if a
       FastCGI server returned an incorrect response; the bug had appeared
       in 1.19.1.

    *) Bugfix: a segmentation fault might occur in a worker process if
       different large_client_header_buffers sizes were used in different
       virtual servers.

    *) Bugfix: SSL shutdown might not work.

    *) Bugfix: "SSL_shutdown() failed (SSL: ... bad write retry)" messages
       might appear in logs.

    *) Bugfix: in the ngx_http_slice_module.

    *) Bugfix: in the ngx_http_xslt_filter_module.


Changes with nginx 1.19.1                                        07 Jul 2020

    *) Change: the "lingering_close", "lingering_time", and
       "lingering_timeout" directives now work when using HTTP/2.

    *) Change: now extra data sent by a backend are always discarded.

    *) Change: now after receiving a too short response from a FastCGI
       server nginx tries to send the available part of the response to the
       client, and then closes the client connection.

    *) Change: now after receiving a response with incorrect length from a
       gRPC backend nginx stops response processing with an error.

    *) Feature: the "min_free" parameter of the "proxy_cache_path",
       "fastcgi_cache_path", "scgi_cache_path", and "uwsgi_cache_path"
       directives.
       Thanks to Adam Bambuch.

    *) Bugfix: nginx did not delete unix domain listen sockets during
       graceful shutdown on the SIGQUIT signal.

    *) Bugfix: zero length UDP datagrams were not proxied.

    *) Bugfix: proxying to uwsgi backends using SSL might not work.
       Thanks to Guanzhong Chen.

    *) Bugfix: in error handling when using the "ssl_ocsp" directive.

    *) Bugfix: on XFS and NFS file systems disk cache size might be
       calculated incorrectly.

    *) Bugfix: "negative size buf in writer" alerts might appear in logs if
       a memcached server returned a malformed response.


Changes with nginx 1.19.0                                        26 May 2020

    *) Feature: client certificate validation with OCSP.

    *) Bugfix: "upstream sent frame for closed stream" errors might occur
       when working with gRPC backends.

    *) Bugfix: OCSP stapling might not work if the "resolver" directive was
       not specified.

    *) Bugfix: connections with incorrect HTTP/2 preface were not logged.


Changes with nginx 1.17.10                                       14 Apr 2020

    *) Feature: the "auth_delay" directive.


Changes with nginx 1.17.9                                        03 Mar 2020

    *) Change: now nginx does not allow several "Host" request header lines.

    *) Bugfix: nginx ignored additional "Transfer-Encoding" request header
       lines.

    *) Bugfix: socket leak when using HTTP/2.

    *) Bugfix: a segmentation fault might occur in a worker process if OCSP
       stapling was used.

    *) Bugfix: in the ngx_http_mp4_module.

    *) Bugfix: nginx used status code 494 instead of 400 if errors with code
       494 were redirected with the "error_page" directive.

    *) Bugfix: socket leak when using subrequests in the njs module and the
       "aio" directive.


Changes with nginx 1.17.8                                        21 Jan 2020

    *) Feature: variables support in the "grpc_pass" directive.

    *) Bugfix: a timeout might occur while handling pipelined requests in an
       SSL connection; the bug had appeared in 1.17.5.

    *) Bugfix: in the "debug_points" directive when using HTTP/2.
       Thanks to Daniil Bondarev.


Changes with nginx 1.17.7                                        24 Dec 2019

    *) Bugfix: a segmentation fault might occur on start or during
       reconfiguration if the "rewrite" directive with an empty replacement
       string was used in the configuration.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "break" directive was used with the "alias" directive or with the
       "proxy_pass" directive with a URI.

    *) Bugfix: the "Location" response header line might contain garbage if
       the request URI was rewritten to the one containing a null character.

    *) Bugfix: requests with bodies were handled incorrectly when returning
       redirections with the "error_page" directive; the bug had appeared in
       0.7.12.

    *) Bugfix: socket leak when using HTTP/2.

    *) Bugfix: a timeout might occur while handling pipelined requests in an
       SSL connection; the bug had appeared in 1.17.5.

    *) Bugfix: in the ngx_http_dav_module.


Changes with nginx 1.17.6                                        19 Nov 2019

    *) Feature: the $proxy_protocol_server_addr and
       $proxy_protocol_server_port variables.

    *) Feature: the "limit_conn_dry_run" directive.

    *) Feature: the $limit_req_status and $limit_conn_status variables.


Changes with nginx 1.17.5                                        22 Oct 2019

    *) Feature: now nginx uses ioctl(FIONREAD), if available, to avoid
       reading from a fast connection for a long time.

    *) Bugfix: incomplete escaped characters at the end of the request URI
       were ignored.

    *) Bugfix: "/." and "/.." at the end of the request URI were not
       normalized.

    *) Bugfix: in the "merge_slashes" directive.

    *) Bugfix: in the "ignore_invalid_headers" directive.
       Thanks to Alan Kemp.

    *) Bugfix: nginx could not be built with MinGW-w64 gcc 8.1 or newer.


Changes with nginx 1.17.4                                        24 Sep 2019

    *) Change: better detection of incorrect client behavior in HTTP/2.

    *) Change: in handling of not fully read client request body when
       returning errors in HTTP/2.

    *) Bugfix: the "worker_shutdown_timeout" directive might not work when
       using HTTP/2.

    *) Bugfix: a segmentation fault might occur in a worker process when
       using HTTP/2 and the "proxy_request_buffering" directive.

    *) Bugfix: the ECONNABORTED error log level was "crit" instead of
       "error" on Windows when using SSL.

    *) Bugfix: nginx ignored extra data when using chunked transfer
       encoding.

    *) Bugfix: nginx always returned the 500 error if the "return" directive
       was used and an error occurred during reading client request body.

    *) Bugfix: in memory allocation error handling.


Changes with nginx 1.17.3                                        13 Aug 2019

    *) Security: when using HTTP/2 a client might cause excessive memory
       consumption and CPU usage (CVE-2019-9511, CVE-2019-9513,
       CVE-2019-9516).

    *) Bugfix: "zero size buf" alerts might appear in logs when using
       gzipping; the bug had appeared in 1.17.2.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "resolver" directive was used in SMTP proxy.


Changes with nginx 1.17.2                                        23 Jul 2019

    *) Change: minimum supported zlib version is 1.2.0.4.
       Thanks to Ilya Leoshkevich.

    *) Change: the $r->internal_redirect() embedded perl method now expects
       escaped URIs.

    *) Feature: it is now possible to switch to a named location using the
       $r->internal_redirect() embedded perl method.

    *) Bugfix: in error handling in embedded perl.

    *) Bugfix: a segmentation fault might occur on start or during
       reconfiguration if hash bucket size larger than 64 kilobytes was used
       in the configuration.

    *) Bugfix: nginx might hog CPU during unbuffered proxying and when
       proxying WebSocket connections if the select, poll, or /dev/poll
       methods were used.

    *) Bugfix: in the ngx_http_xslt_filter_module.

    *) Bugfix: in the ngx_http_ssi_filter_module.


Changes with nginx 1.17.1                                        25 Jun 2019

    *) Feature: the "limit_req_dry_run" directive.

    *) Feature: when using the "hash" directive inside the "upstream" block
       an empty hash key now triggers round-robin balancing.
       Thanks to Niklas Keller.

    *) Bugfix: a segmentation fault might occur in a worker process if
       caching was used along with the "image_filter" directive, and errors
       with code 415 were redirected with the "error_page" directive; the
       bug had appeared in 1.11.10.

    *) Bugfix: a segmentation fault might occur in a worker process if
       embedded perl was used; the bug had appeared in 1.7.3.


Changes with nginx 1.17.0                                        21 May 2019

    *) Feature: variables support in the "limit_rate" and "limit_rate_after"
       directives.

    *) Feature: variables support in the "proxy_upload_rate" and
       "proxy_download_rate" directives in the stream module.

    *) Change: minimum supported OpenSSL version is 0.9.8.

    *) Change: now the postpone filter is always built.

    *) Bugfix: the "include" directive did not work inside the "if" and
       "limit_except" blocks.

    *) Bugfix: in byte ranges processing.


Changes with nginx 1.15.12                                       16 Apr 2019

    *) Bugfix: a segmentation fault might occur in a worker process if
       variables were used in the "ssl_certificate" or "ssl_certificate_key"
       directives and OCSP stapling was enabled.


Changes with nginx 1.15.11                                       09 Apr 2019

    *) Bugfix: in the "ssl_stapling_file" directive on Windows.


Changes with nginx 1.15.10                                       26 Mar 2019

    *) Change: when using a hostname in the "listen" directive nginx now
       creates listening sockets for all addresses the hostname resolves to
       (previously, only the first address was used).

    *) Feature: port ranges in the "listen" directive.

    *) Feature: loading of SSL certificates and secret keys from variables.

    *) Workaround: the $ssl_server_name variable might be empty when using
       OpenSSL 1.1.1.

    *) Bugfix: nginx/Windows could not be built with Visual Studio 2015 or
       newer; the bug had appeared in 1.15.9.


Changes with nginx 1.15.9                                        26 Feb 2019

    *) Feature: variables support in the "ssl_certificate" and
       "ssl_certificate_key" directives.

    *) Feature: the "poll" method is now available on Windows when using
       Windows Vista or newer.

    *) Bugfix: if the "select" method was used on Windows and an error
       occurred while establishing a backend connection, nginx waited for
       the connection establishment timeout to expire.

    *) Bugfix: the "proxy_upload_rate" and "proxy_download_rate" directives
       in the stream module worked incorrectly when proxying UDP datagrams.


Changes with nginx 1.15.8                                        25 Dec 2018

    *) Feature: the $upstream_bytes_sent variable.
       Thanks to Piotr Sikora.

    *) Feature: new directives in vim syntax highlighting scripts.
       Thanks to Gena Makhomed.

    *) Bugfix: in the "proxy_cache_background_update" directive.

    *) Bugfix: in the "geo" directive when using unix domain listen sockets.

    *) Workaround: the "ignoring stale global SSL error ... bad length"
       alerts might appear in logs when using the "ssl_early_data" directive
       with OpenSSL.

    *) Bugfix: in nginx/Windows.

    *) Bugfix: in the ngx_http_autoindex_module on 32-bit platforms.


Changes with nginx 1.15.7                                        27 Nov 2018

    *) Feature: the "proxy_requests" directive in the stream module.

    *) Feature: the "delay" parameter of the "limit_req" directive.
       Thanks to Vladislav Shabanov and Peter Shchuchkin.

    *) Bugfix: memory leak on errors during reconfiguration.

    *) Bugfix: in the $upstream_response_time, $upstream_connect_time, and
       $upstream_header_time variables.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       ngx_http_mp4_module was used on 32-bit platforms.


Changes with nginx 1.15.6                                        06 Nov 2018

    *) Security: when using HTTP/2 a client might cause excessive memory
       consumption (CVE-2018-16843) and CPU usage (CVE-2018-16844).

    *) Security: processing of a specially crafted mp4 file with the
       ngx_http_mp4_module might result in worker process memory disclosure
       (CVE-2018-16845).

    *) Feature: the "proxy_socket_keepalive", "fastcgi_socket_keepalive",
       "grpc_socket_keepalive", "memcached_socket_keepalive",
       "scgi_socket_keepalive", and "uwsgi_socket_keepalive" directives.

    *) Bugfix: if nginx was built with OpenSSL 1.1.0 and used with OpenSSL
       1.1.1, the TLS 1.3 protocol was always enabled.

    *) Bugfix: working with gRPC backends might result in excessive memory
       consumption.


Changes with nginx 1.15.5                                        02 Oct 2018

    *) Bugfix: a segmentation fault might occur in a worker process when
       using OpenSSL 1.1.0h or newer; the bug had appeared in 1.15.4.

    *) Bugfix: of minor potential bugs.


Changes with nginx 1.15.4                                        25 Sep 2018

    *) Feature: now the "ssl_early_data" directive can be used with OpenSSL.

    *) Bugfix: in the ngx_http_uwsgi_module.
       Thanks to Chris Caputo.

    *) Bugfix: connections with some gRPC backends might not be cached when
       using the "keepalive" directive.

    *) Bugfix: a socket leak might occur when using the "error_page"
       directive to redirect early request processing errors, notably errors
       with code 400.

    *) Bugfix: the "return" directive did not change the response code when
       returning errors if the request was redirected by the "error_page"
       directive.

    *) Bugfix: standard error pages and responses of the
       ngx_http_autoindex_module module used the "bgcolor" attribute, and
       might be displayed incorrectly when using custom color settings in
       browsers.
       Thanks to Nova DasSarma.

    *) Change: the logging level of the "no suitable key share" and "no
       suitable signature algorithm" SSL errors has been lowered from "crit"
       to "info".


Changes with nginx 1.15.3                                        28 Aug 2018

    *) Feature: now TLSv1.3 can be used with BoringSSL.

    *) Feature: the "ssl_early_data" directive, currently available with
       BoringSSL.

    *) Feature: the "keepalive_timeout" and "keepalive_requests" directives
       in the "upstream" block.

    *) Bugfix: the ngx_http_dav_module did not truncate destination file
       when copying a file over an existing one with the COPY method.

    *) Bugfix: the ngx_http_dav_module used zero access rights on the
       destination file and did not preserve file modification time when
       moving a file between different file systems with the MOVE method.

    *) Bugfix: the ngx_http_dav_module used default access rights when
       copying a file with the COPY method.

    *) Workaround: some clients might not work when using HTTP/2; the bug
       had appeared in 1.13.5.

    *) Bugfix: nginx could not be built with LibreSSL 2.8.0.


Changes with nginx 1.15.2                                        24 Jul 2018

    *) Feature: the $ssl_preread_protocol variable in the
       ngx_stream_ssl_preread_module.

    *) Feature: now when using the "reset_timedout_connection" directive
       nginx will reset connections being closed with the 444 code.

    *) Change: a logging level of the "http request", "https proxy request",
       "unsupported protocol", and "version too low" SSL errors has been
       lowered from "crit" to "info".

    *) Bugfix: DNS requests were not resent if initial sending of a request
       failed.

    *) Bugfix: the "reuseport" parameter of the "listen" directive was
       ignored if the number of worker processes was specified after the
       "listen" directive.

    *) Bugfix: when using OpenSSL 1.1.0 or newer it was not possible to
       switch off "ssl_prefer_server_ciphers" in a virtual server if it was
       switched on in the default server.

    *) Bugfix: SSL session reuse with upstream servers did not work with the
       TLS 1.3 protocol.


Changes with nginx 1.15.1                                        03 Jul 2018

    *) Feature: the "random" directive inside the "upstream" block.

    *) Feature: improved performance when using the "hash" and "ip_hash"
       directives with the "zone" directive.

    *) Feature: the "reuseport" parameter of the "listen" directive now uses
       SO_REUSEPORT_LB on FreeBSD 12.

    *) Bugfix: HTTP/2 server push did not work if SSL was terminated by a
       proxy server in front of nginx.

    *) Bugfix: the "tcp_nopush" directive was always used on backend
       connections.

    *) Bugfix: sending a disk-buffered request body to a gRPC backend might
       fail.


Changes with nginx 1.15.0                                        05 Jun 2018

    *) Change: the "ssl" directive is deprecated; the "ssl" parameter of the
       "listen" directive should be used instead.

    *) Change: now nginx detects missing SSL certificates during
       configuration testing when using the "ssl" parameter of the "listen"
       directive.

    *) Feature: now the stream module can handle multiple incoming UDP
       datagrams from a client within a single session.

    *) Bugfix: it was possible to specify an incorrect response code in the
       "proxy_cache_valid" directive.

    *) Bugfix: nginx could not be built by gcc 8.1.

    *) Bugfix: logging to syslog stopped on local IP address changes.

    *) Bugfix: nginx could not be built by clang with CUDA SDK installed;
       the bug had appeared in 1.13.8.

    *) Bugfix: "getsockopt(TCP_FASTOPEN) ... failed" messages might appear
       in logs during binary upgrade when using unix domain listen sockets
       on FreeBSD.

    *) Bugfix: nginx could not be built on Fedora 28 Linux.

    *) Bugfix: request processing rate might exceed configured rate when
       using the "limit_req" directive.

    *) Bugfix: in handling of client addresses when using unix domain listen
       sockets to work with datagrams on Linux.

    *) Bugfix: in memory allocation error handling.


Changes with nginx 1.13.12                                       10 Apr 2018

    *) Bugfix: connections with gRPC backends might be closed unexpectedly
       when returning a large response.


Changes with nginx 1.13.11                                       03 Apr 2018

    *) Feature: the "proxy_protocol" parameter of the "listen" directive now
       supports the PROXY protocol version 2.

    *) Bugfix: nginx could not be built with OpenSSL 1.1.1 statically on
       Linux.

    *) Bugfix: in the "http_404", "http_500", etc. parameters of the
       "proxy_next_upstream" directive.


Changes with nginx 1.13.10                                       20 Mar 2018

    *) Feature: the "set" parameter of the "include" SSI directive now
       allows writing arbitrary responses to a variable; the
       "subrequest_output_buffer_size" directive defines maximum response
       size.

    *) Feature: now nginx uses clock_gettime(CLOCK_MONOTONIC) if available,
       to avoid timeouts being incorrectly triggered on system time changes.

    *) Feature: the "escape=none" parameter of the "log_format" directive.
       Thanks to Johannes Baiter and Calin Don.

    *) Feature: the $ssl_preread_alpn_protocols variable in the
       ngx_stream_ssl_preread_module.

    *) Feature: the ngx_http_grpc_module.

    *) Bugfix: in memory allocation error handling in the "geo" directive.

    *) Bugfix: when using variables in the "auth_basic_user_file" directive
       a null character might appear in logs.
       Thanks to Vadim Filimonov.


Changes with nginx 1.13.9                                        20 Feb 2018

    *) Feature: HTTP/2 server push support; the "http2_push" and
       "http2_push_preload" directives.

    *) Bugfix: "header already sent" alerts might appear in logs when using
       cache; the bug had appeared in 1.9.13.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "ssl_verify_client" directive was used and no SSL certificate was
       specified in a virtual server.

    *) Bugfix: in the ngx_http_v2_module.

    *) Bugfix: in the ngx_http_dav_module.


Changes with nginx 1.13.8                                        26 Dec 2017

    *) Feature: now nginx automatically preserves the CAP_NET_RAW capability
       in worker processes when using the "transparent" parameter of the
       "proxy_bind", "fastcgi_bind", "memcached_bind", "scgi_bind", and
       "uwsgi_bind" directives.

    *) Feature: improved CPU cache line size detection.
       Thanks to Debayan Ghosh.

    *) Feature: new directives in vim syntax highlighting scripts.
       Thanks to Gena Makhomed.

    *) Bugfix: binary upgrade refused to work if nginx was re-parented to a
       process with PID different from 1 after its parent process has
       finished.

    *) Bugfix: the ngx_http_autoindex_module incorrectly handled requests
       with bodies.

    *) Bugfix: in the "proxy_limit_rate" directive when used with the
       "keepalive" directive.

    *) Bugfix: some parts of a response might be buffered when using
       "proxy_buffering off" if the client connection used SSL.
       Thanks to Patryk Lesiewicz.

    *) Bugfix: in the "proxy_cache_background_update" directive.

    *) Bugfix: it was not possible to start a parameter with a variable in
       the "${name}" form with the name in curly brackets without enclosing
       the parameter into single or double quotes.


Changes with nginx 1.13.7                                        21 Nov 2017

    *) Bugfix: in the $upstream_status variable.

    *) Bugfix: a segmentation fault might occur in a worker process if a
       backend returned a "101 Switching Protocols" response to a
       subrequest.

    *) Bugfix: a segmentation fault occurred in a master process if a shared
       memory zone size was changed during a reconfiguration and the
       reconfiguration failed.

    *) Bugfix: in the ngx_http_fastcgi_module.

    *) Bugfix: nginx returned the 500 error if parameters without variables
       were specified in the "xslt_stylesheet" directive.

    *) Workaround: "gzip filter failed to use preallocated memory" alerts
       appeared in logs when using a zlib library variant from Intel.

    *) Bugfix: the "worker_shutdown_timeout" directive did not work when
       using mail proxy and when proxying WebSocket connections.


Changes with nginx 1.13.6                                        10 Oct 2017

    *) Bugfix: switching to the next upstream server in the stream module
       did not work when using the "ssl_preread" directive.

    *) Bugfix: in the ngx_http_v2_module.
       Thanks to Piotr Sikora.

    *) Bugfix: nginx did not support dates after the year 2038 on 32-bit
       platforms with 64-bit time_t.

    *) Bugfix: in handling of dates prior to the year 1970 and after the
       year 10000.

    *) Bugfix: in the stream module timeouts waiting for UDP datagrams from
       upstream servers were not logged or logged at the "info" level
       instead of "error".

    *) Bugfix: when using HTTP/2 nginx might return the 400 response without
       logging the reason.

    *) Bugfix: in processing of corrupted cache files.

    *) Bugfix: cache control headers were ignored when caching errors
       intercepted by error_page.

    *) Bugfix: when using HTTP/2 client request body might be corrupted.

    *) Bugfix: in handling of client addresses when using unix domain
       sockets.

    *) Bugfix: nginx hogged CPU when using the "hash ... consistent"
       directive in the upstream block if large weights were used and all or
       most of the servers were unavailable.


Changes with nginx 1.13.5                                        05 Sep 2017

    *) Feature: the $ssl_client_escaped_cert variable.

    *) Bugfix: the "ssl_session_ticket_key" directive and the "include"
       parameter of the "geo" directive did not work on Windows.

    *) Bugfix: incorrect response length was returned on 32-bit platforms
       when requesting more than 4 gigabytes with multiple ranges.

    *) Bugfix: the "expires modified" directive and processing of the
       "If-Range" request header line did not use the response last
       modification time if proxying without caching was used.


Changes with nginx 1.13.4                                        08 Aug 2017

    *) Feature: the ngx_http_mirror_module.

    *) Bugfix: client connections might be dropped during configuration
       testing when using the "reuseport" parameter of the "listen"
       directive on Linux.

    *) Bugfix: request body might not be available in subrequests if it was
       saved to a file and proxying was used.

    *) Bugfix: cleaning cache based on the "max_size" parameter did not work
       on Windows.

    *) Bugfix: any shared memory allocation required 4096 bytes on Windows.

    *) Bugfix: nginx worker might be terminated abnormally when using the
       "zone" directive inside the "upstream" block on Windows.


Changes with nginx 1.13.3                                        11 Jul 2017

    *) Security: a specially crafted request might result in an integer
       overflow and incorrect processing of ranges in the range filter,
       potentially resulting in sensitive information leak (CVE-2017-7529).


Changes with nginx 1.13.2                                        27 Jun 2017

    *) Change: nginx now returns 200 instead of 416 when a range starting
       with 0 is requested from an empty file.

    *) Feature: the "add_trailer" directive.
       Thanks to Piotr Sikora.

    *) Bugfix: nginx could not be built on Cygwin and NetBSD; the bug had
       appeared in 1.13.0.

    *) Bugfix: nginx could not be built under MSYS2 / MinGW 64-bit.
       Thanks to Orgad Shaneh.

    *) Bugfix: a segmentation fault might occur in a worker process when
       using SSI with many includes and proxy_pass with variables.

    *) Bugfix: in the ngx_http_v2_module.
       Thanks to Piotr Sikora.


Changes with nginx 1.13.1                                        30 May 2017

    *) Feature: now a hostname can be used as the "set_real_ip_from"
       directive parameter.

    *) Feature: vim syntax highlighting scripts improvements.

    *) Feature: the "worker_cpu_affinity" directive now works on DragonFly
       BSD.
       Thanks to Sepherosa Ziehau.

    *) Bugfix: SSL renegotiation on backend connections did not work when
       using OpenSSL before 1.1.0.

    *) Workaround: nginx could not be built with Oracle Developer Studio
       12.5.

    *) Workaround: now cache manager ignores long locked cache entries when
       cleaning cache based on the "max_size" parameter.

    *) Bugfix: client SSL connections were immediately closed if deferred
       accept and the "proxy_protocol" parameter of the "listen" directive
       were used.

    *) Bugfix: in the "proxy_cache_background_update" directive.

    *) Workaround: now the "tcp_nodelay" directive sets the TCP_NODELAY
       option before an SSL handshake.


Changes with nginx 1.13.0                                        25 Apr 2017

    *) Change: SSL renegotiation is now allowed on backend connections.

    *) Feature: the "rcvbuf" and "sndbuf" parameters of the "listen"
       directives of the mail proxy and stream modules.

    *) Feature: the "return" and "error_page" directives can now be used to
       return 308 redirections.
       Thanks to Simon Leblanc.

    *) Feature: the "TLSv1.3" parameter of the "ssl_protocols" directive.

    *) Feature: when logging signals nginx now logs PID of the process which
       sent the signal.

    *) Bugfix: in memory allocation error handling.

    *) Bugfix: if a server in the stream module listened on a wildcard
       address, the source address of a response UDP datagram could differ
       from the original datagram destination address.


Changes with nginx 1.11.13                                       04 Apr 2017

    *) Feature: the "http_429" parameter of the "proxy_next_upstream",
       "fastcgi_next_upstream", "scgi_next_upstream", and
       "uwsgi_next_upstream" directives.
       Thanks to Piotr Sikora.

    *) Bugfix: in memory allocation error handling.

    *) Bugfix: requests might hang when using the "sendfile" and
       "timer_resolution" directives on Linux.

    *) Bugfix: requests might hang when using the "sendfile" and "aio_write"
       directives with subrequests.

    *) Bugfix: in the ngx_http_v2_module.
       Thanks to Piotr Sikora.

    *) Bugfix: a segmentation fault might occur in a worker process when
       using HTTP/2.

    *) Bugfix: requests might hang when using the "limit_rate",
       "sendfile_max_chunk", "limit_req" directives, or the $r->sleep()
       embedded perl method with subrequests.

    *) Bugfix: in the ngx_http_slice_module.


Changes with nginx 1.11.12                                       24 Mar 2017

    *) Bugfix: nginx might hog CPU; the bug had appeared in 1.11.11.


Changes with nginx 1.11.11                                       21 Mar 2017

    *) Feature: the "worker_shutdown_timeout" directive.

    *) Feature: vim syntax highlighting scripts improvements.
       Thanks to Wei-Ko Kao.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       $limit_rate variable was set to an empty string.

    *) Bugfix: the "proxy_cache_background_update",
       "fastcgi_cache_background_update", "scgi_cache_background_update",
       and "uwsgi_cache_background_update" directives might work incorrectly
       if the "if" directive was used.

    *) Bugfix: a segmentation fault might occur in a worker process if
       number of large_client_header_buffers in a virtual server was
       different from the one in the default server.

    *) Bugfix: in the mail proxy server.


Changes with nginx 1.11.10                                       14 Feb 2017

    *) Change: cache header format has been changed, previously cached
       responses will be invalidated.

    *) Feature: support of "stale-while-revalidate" and "stale-if-error"
       extensions in the "Cache-Control" backend response header line.

    *) Feature: the "proxy_cache_background_update",
       "fastcgi_cache_background_update", "scgi_cache_background_update",
       and "uwsgi_cache_background_update" directives.

    *) Feature: nginx is now able to cache responses with the "Vary" header
       line up to 128 characters long (instead of 42 characters in previous
       versions).

    *) Feature: the "build" parameter of the "server_tokens" directive.
       Thanks to Tom Thorogood.

    *) Bugfix: "[crit] SSL_write() failed" messages might appear in logs
       when handling requests with the "Expect: 100-continue" request header
       line.

    *) Bugfix: the ngx_http_slice_module did not work in named locations.

    *) Bugfix: a segmentation fault might occur in a worker process when
       using AIO after an "X-Accel-Redirect" redirection.

    *) Bugfix: reduced memory consumption for long-lived requests using
       gzipping.


Changes with nginx 1.11.9                                        24 Jan 2017

    *) Bugfix: nginx might hog CPU when using the stream module; the bug had
       appeared in 1.11.5.

    *) Bugfix: EXTERNAL authentication mechanism in mail proxy was accepted
       even if it was not enabled in the configuration.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "ssl_verify_client" directive of the stream module was used.

    *) Bugfix: the "ssl_verify_client" directive of the stream module might
       not work.

    *) Bugfix: closing keepalive connections due to no free worker
       connections might be too aggressive.
       Thanks to Joel Cunningham.

    *) Bugfix: an incorrect response might be returned when using the
       "sendfile" directive on FreeBSD and macOS; the bug had appeared in
       1.7.8.

    *) Bugfix: a truncated response might be stored in cache when using the
       "aio_write" directive.

    *) Bugfix: a socket leak might occur when using the "aio_write"
       directive.


Changes with nginx 1.11.8                                        27 Dec 2016

    *) Feature: the "absolute_redirect" directive.

    *) Feature: the "escape" parameter of the "log_format" directive.

    *) Feature: client SSL certificates verification in the stream module.

    *) Feature: the "ssl_session_ticket_key" directive supports AES256
       encryption of TLS session tickets when used with 80-byte keys.

    *) Feature: vim-commentary support in vim scripts.
       Thanks to Armin Grodon.

    *) Bugfix: recursion when evaluating variables was not limited.

    *) Bugfix: in the ngx_stream_ssl_preread_module.

    *) Bugfix: if a server in an upstream in the stream module failed, it
       was considered alive only when a test connection sent to it after
       fail_timeout was closed; now a successfully established connection is
       enough.

    *) Bugfix: nginx/Windows could not be built with 64-bit Visual Studio.

    *) Bugfix: nginx/Windows could not be built with OpenSSL 1.1.0.


Changes with nginx 1.11.7                                        13 Dec 2016

    *) Change: now in case of a client certificate verification error the
       $ssl_client_verify variable contains a string with the failure
       reason, for example, "FAILED:certificate has expired".

    *) Feature: the $ssl_ciphers, $ssl_curves, $ssl_client_v_start,
       $ssl_client_v_end, and $ssl_client_v_remain variables.

    *) Feature: the "volatile" parameter of the "map" directive.

    *) Bugfix: dependencies specified for a module were ignored while
       building dynamic modules.

    *) Bugfix: when using HTTP/2 and the "limit_req" or "auth_request"
       directives client request body might be corrupted; the bug had
       appeared in 1.11.0.

    *) Bugfix: a segmentation fault might occur in a worker process when
       using HTTP/2; the bug had appeared in 1.11.3.

    *) Bugfix: in the ngx_http_mp4_module.
       Thanks to Congcong Hu.

    *) Bugfix: in the ngx_http_perl_module.


Changes with nginx 1.11.6                                        15 Nov 2016

    *) Change: format of the $ssl_client_s_dn and $ssl_client_i_dn variables
       has been changed to follow RFC 2253 (RFC 4514); values in the old
       format are available in the $ssl_client_s_dn_legacy and
       $ssl_client_i_dn_legacy variables.

    *) Change: when storing temporary files in a cache directory they will
       be stored in the same subdirectories as corresponding cache files
       instead of a separate subdirectory for temporary files.

    *) Feature: EXTERNAL authentication mechanism support in mail proxy.
       Thanks to Robert Norris.

    *) Feature: WebP support in the ngx_http_image_filter_module.

    *) Feature: variables support in the "proxy_method" directive.
       Thanks to Dmitry Lazurkin.

    *) Feature: the "http2_max_requests" directive in the
       ngx_http_v2_module.

    *) Feature: the "proxy_cache_max_range_offset",
       "fastcgi_cache_max_range_offset", "scgi_cache_max_range_offset", and
       "uwsgi_cache_max_range_offset" directives.

    *) Bugfix: graceful shutdown of old worker processes might require
       infinite time when using HTTP/2.

    *) Bugfix: in the ngx_http_mp4_module.

    *) Bugfix: "ignore long locked inactive cache entry" alerts might appear
       in logs when proxying WebSocket connections with caching enabled.

    *) Bugfix: nginx did not write anything to log and returned a response
       with code 502 instead of 504 when a timeout occurred during an SSL
       handshake to a backend.


Changes with nginx 1.11.5                                        11 Oct 2016

    *) Change: the --with-ipv6 configure option was removed, now IPv6
       support is configured automatically.

    *) Change: now if there are no available servers in an upstream, nginx
       will not reset number of failures of all servers as it previously
       did, but will wait for fail_timeout to expire.

    *) Feature: the ngx_stream_ssl_preread_module.

    *) Feature: the "server" directive in the "upstream" context supports
       the "max_conns" parameter.

    *) Feature: the --with-compat configure option.

    *) Feature: "manager_files", "manager_threshold", and "manager_sleep"
       parameters of the "proxy_cache_path", "fastcgi_cache_path",
       "scgi_cache_path", and "uwsgi_cache_path" directives.

    *) Bugfix: flags passed by the --with-ld-opt configure option were not
       used while building perl module.

    *) Bugfix: in the "add_after_body" directive when used with the
       "sub_filter" directive.

    *) Bugfix: in the $realip_remote_addr variable.

    *) Bugfix: the "dav_access", "proxy_store_access",
       "fastcgi_store_access", "scgi_store_access", and "uwsgi_store_access"
       directives ignored permissions specified for user.

    *) Bugfix: unix domain listen sockets might not be inherited during
       binary upgrade on Linux.

    *) Bugfix: nginx returned the 400 response on requests with the "-"
       character in the HTTP method.


Changes with nginx 1.11.4                                        13 Sep 2016

    *) Feature: the $upstream_bytes_received variable.

    *) Feature: the $bytes_received, $session_time, $protocol, $status,
       $upstream_addr, $upstream_bytes_sent, $upstream_bytes_received,
       $upstream_connect_time, $upstream_first_byte_time, and
       $upstream_session_time variables in the stream module.

    *) Feature: the ngx_stream_log_module.

    *) Feature: the "proxy_protocol" parameter of the "listen" directive,
       the $proxy_protocol_addr and $proxy_protocol_port variables in the
       stream module.

    *) Feature: the ngx_stream_realip_module.

    *) Bugfix: nginx could not be built with the stream module and the
       ngx_http_ssl_module, but without ngx_stream_ssl_module; the bug had
       appeared in 1.11.3.

    *) Feature: the IP_BIND_ADDRESS_NO_PORT socket option was not used; the
       bug had appeared in 1.11.2.

    *) Bugfix: in the "ranges" parameter of the "geo" directive.

    *) Bugfix: an incorrect response might be returned when using the "aio
       threads" and "sendfile" directives; the bug had appeared in 1.9.13.


Changes with nginx 1.11.3                                        26 Jul 2016

    *) Change: now the "accept_mutex" directive is turned off by default.

    *) Feature: now nginx uses EPOLLEXCLUSIVE on Linux.

    *) Feature: the ngx_stream_geo_module.

    *) Feature: the ngx_stream_geoip_module.

    *) Feature: the ngx_stream_split_clients_module.

    *) Feature: variables support in the "proxy_pass" and "proxy_ssl_name"
       directives in the stream module.

    *) Bugfix: socket leak when using HTTP/2.

    *) Bugfix: in configure tests.
       Thanks to Piotr Sikora.


Changes with nginx 1.11.2                                        05 Jul 2016

    *) Change: now nginx always uses internal MD5 and SHA1 implementations;
       the --with-md5 and --with-sha1 configure options were canceled.

    *) Feature: variables support in the stream module.

    *) Feature: the ngx_stream_map_module.

    *) Feature: the ngx_stream_return_module.

    *) Feature: a port can be specified in the "proxy_bind", "fastcgi_bind",
       "memcached_bind", "scgi_bind", and "uwsgi_bind" directives.

    *) Feature: now nginx uses the IP_BIND_ADDRESS_NO_PORT socket option
       when available.

    *) Bugfix: a segmentation fault might occur in a worker process when
       using HTTP/2 and the "proxy_request_buffering" directive.

    *) Bugfix: the "Content-Length" request header line was always added to
       requests passed to backends, including requests without body, when
       using HTTP/2.

    *) Bugfix: "http request count is zero" alerts might appear in logs when
       using HTTP/2.

    *) Bugfix: unnecessary buffering might occur when using the "sub_filter"
       directive; the issue had appeared in 1.9.4.


Changes with nginx 1.11.1                                        31 May 2016

    *) Security: a segmentation fault might occur in a worker process while
       writing a specially crafted request body to a temporary file
       (CVE-2016-4450); the bug had appeared in 1.3.9.


Changes with nginx 1.11.0                                        24 May 2016

    *) Feature: the "transparent" parameter of the "proxy_bind",
       "fastcgi_bind", "memcached_bind", "scgi_bind", and "uwsgi_bind"
       directives.

    *) Feature: the $request_id variable.

    *) Feature: the "map" directive supports combinations of multiple
       variables as resulting values.

    *) Feature: now nginx checks if EPOLLRDHUP events are supported by
       kernel, and optimizes connection handling accordingly if the "epoll"
       method is used.

    *) Feature: the "ssl_certificate" and "ssl_certificate_key" directives
       can be specified multiple times to load certificates of different
       types (for example, RSA and ECDSA).

    *) Feature: the "ssl_ecdh_curve" directive now allows specifying a list
       of curves when using OpenSSL 1.0.2 or newer; by default a list built
       into OpenSSL is used.

    *) Change: to use DHE ciphers it is now required to specify parameters
       using the "ssl_dhparam" directive.

    *) Feature: the $proxy_protocol_port variable.

    *) Feature: the $realip_remote_port variable in the
       ngx_http_realip_module.

    *) Feature: the ngx_http_realip_module is now able to set the client
       port in addition to the address.

    *) Change: the "421 Misdirected Request" response now used when
       rejecting requests to a virtual server different from one negotiated
       during an SSL handshake; this improves interoperability with some
       HTTP/2 clients when using client certificates.

    *) Change: HTTP/2 clients can now start sending request body
       immediately; the "http2_body_preread_size" directive controls size of
       the buffer used before nginx will start reading client request body.

    *) Bugfix: cached error responses were not updated when using the
       "proxy_cache_bypass" directive.


Changes with nginx 1.9.15                                        19 Apr 2016

    *) Bugfix: "recv() failed" errors might occur when using HHVM as a
       FastCGI server.

    *) Bugfix: when using HTTP/2 and the "limit_req" or "auth_request"
       directives a timeout or a "client violated flow control" error might
       occur while reading client request body; the bug had appeared in
       1.9.14.

    *) Workaround: a response might not be shown by some browsers if HTTP/2
       was used and client request body was not fully read; the bug had
       appeared in 1.9.14.

    *) Bugfix: connections might hang when using the "aio threads"
       directive.
       Thanks to Mindaugas Rasiukevicius.


Changes with nginx 1.9.14                                        05 Apr 2016

    *) Feature: OpenSSL 1.1.0 compatibility.

    *) Feature: the "proxy_request_buffering", "fastcgi_request_buffering",
       "scgi_request_buffering", and "uwsgi_request_buffering" directives
       now work with HTTP/2.

    *) Bugfix: "zero size buf in output" alerts might appear in logs when
       using HTTP/2.

    *) Bugfix: the "client_max_body_size" directive might work incorrectly
       when using HTTP/2.

    *) Bugfix: of minor bugs in logging.


Changes with nginx 1.9.13                                        29 Mar 2016

    *) Change: non-idempotent requests (POST, LOCK, PATCH) are no longer
       passed to the next server by default if a request has been sent to a
       backend; the "non_idempotent" parameter of the "proxy_next_upstream"
       directive explicitly allows retrying such requests.

    *) Feature: the ngx_http_perl_module can be built dynamically.

    *) Feature: UDP support in the stream module.

    *) Feature: the "aio_write" directive.

    *) Feature: now cache manager monitors number of elements in caches and
       tries to avoid cache keys zone overflows.

    *) Bugfix: "task already active" and "second aio post" alerts might
       appear in logs when using the "sendfile" and "aio" directives with
       subrequests.

    *) Bugfix: "zero size buf in output" alerts might appear in logs if
       caching was used and a client closed a connection prematurely.

    *) Bugfix: connections with clients might be closed needlessly if
       caching was used.
       Thanks to Justin Li.

    *) Bugfix: nginx might hog CPU if the "sendfile" directive was used on
       Linux or Solaris and a file being sent was changed during sending.

    *) Bugfix: connections might hang when using the "sendfile" and "aio
       threads" directives.

    *) Bugfix: in the "proxy_pass", "fastcgi_pass", "scgi_pass", and
       "uwsgi_pass" directives when using variables.
       Thanks to Piotr Sikora.

    *) Bugfix: in the ngx_http_sub_filter_module.

    *) Bugfix: if an error occurred in a cached backend connection, the
       request was passed to the next server regardless of the
       proxy_next_upstream directive.

    *) Bugfix: "CreateFile() failed" errors when creating temporary files on
       Windows.


Changes with nginx 1.9.12                                        24 Feb 2016

    *) Feature: Huffman encoding of response headers in HTTP/2.
       Thanks to Vlad Krasnov.

    *) Feature: the "worker_cpu_affinity" directive now supports more than
       64 CPUs.

    *) Bugfix: compatibility with 3rd party C++ modules; the bug had
       appeared in 1.9.11.
       Thanks to Piotr Sikora.

    *) Bugfix: nginx could not be built statically with OpenSSL on Linux;
       the bug had appeared in 1.9.11.

    *) Bugfix: the "add_header ... always" directive with an empty value did
       not delete "Last-Modified" and "ETag" header lines from error
       responses.

    *) Workaround: "called a function you should not call" and "shutdown
       while in init" messages might appear in logs when using OpenSSL
       1.0.2f.

    *) Bugfix: invalid headers might be logged incorrectly.

    *) Bugfix: socket leak when using HTTP/2.

    *) Bugfix: in the ngx_http_v2_module.


Changes with nginx 1.9.11                                        09 Feb 2016

    *) Feature: TCP support in resolver.

    *) Feature: dynamic modules.

    *) Bugfix: the $request_length variable did not include size of request
       headers when using HTTP/2.

    *) Bugfix: in the ngx_http_v2_module.


Changes with nginx 1.9.10                                        26 Jan 2016

    *) Security: invalid pointer dereference might occur during DNS server
       response processing if the "resolver" directive was used, allowing an
       attacker who is able to forge UDP packets from the DNS server to
       cause segmentation fault in a worker process (CVE-2016-0742).

    *) Security: use-after-free condition might occur during CNAME response
       processing if the "resolver" directive was used, allowing an attacker
       who is able to trigger name resolution to cause segmentation fault in
       a worker process, or might have potential other impact
       (CVE-2016-0746).

    *) Security: CNAME resolution was insufficiently limited if the
       "resolver" directive was used, allowing an attacker who is able to
       trigger arbitrary name resolution to cause excessive resource
       consumption in worker processes (CVE-2016-0747).

    *) Feature: the "auto" parameter of the "worker_cpu_affinity" directive.

    *) Bugfix: the "proxy_protocol" parameter of the "listen" directive did
       not work with IPv6 listen sockets.

    *) Bugfix: connections to upstream servers might be cached incorrectly
       when using the "keepalive" directive.

    *) Bugfix: proxying used the HTTP method of the original request after
       an "X-Accel-Redirect" redirection.


Changes with nginx 1.9.9                                         09 Dec 2015

    *) Bugfix: proxying to unix domain sockets did not work when using
       variables; the bug had appeared in 1.9.8.


Changes with nginx 1.9.8                                         08 Dec 2015

    *) Feature: pwritev() support.

    *) Feature: the "include" directive inside the "upstream" block.

    *) Feature: the ngx_http_slice_module.

    *) Bugfix: a segmentation fault might occur in a worker process when
       using LibreSSL; the bug had appeared in 1.9.6.

    *) Bugfix: nginx could not be built on OS X in some cases.


Changes with nginx 1.9.7                                         17 Nov 2015

    *) Feature: the "nohostname" parameter of logging to syslog.

    *) Feature: the "proxy_cache_convert_head" directive.

    *) Feature: the $realip_remote_addr variable in the
       ngx_http_realip_module.

    *) Bugfix: the "expires" directive might not work when using variables.

    *) Bugfix: a segmentation fault might occur in a worker process when
       using HTTP/2; the bug had appeared in 1.9.6.

    *) Bugfix: if nginx was built with the ngx_http_v2_module it was
       possible to use the HTTP/2 protocol even if the "http2" parameter of
       the "listen" directive was not specified.

    *) Bugfix: in the ngx_http_v2_module.


Changes with nginx 1.9.6                                         27 Oct 2015

    *) Bugfix: a segmentation fault might occur in a worker process when
       using HTTP/2.
       Thanks to Piotr Sikora and Denis Andzakovic.

    *) Bugfix: the $server_protocol variable was empty when using HTTP/2.

    *) Bugfix: backend SSL connections in the stream module might be timed
       out unexpectedly.

    *) Bugfix: a segmentation fault might occur in a worker process if
       different ssl_session_cache settings were used in different virtual
       servers.

    *) Bugfix: nginx/Windows could not be built with MinGW gcc; the bug had
       appeared in 1.9.4.
       Thanks to Kouhei Sutou.

    *) Bugfix: time was not updated when the timer_resolution directive was
       used on Windows.

    *) Miscellaneous minor fixes and improvements.
       Thanks to Markus Linnala, Kurtis Nusbaum and Piotr Sikora.


Changes with nginx 1.9.5                                         22 Sep 2015

    *) Feature: the ngx_http_v2_module (replaces ngx_http_spdy_module).
       Thanks to Dropbox and Automattic for sponsoring this work.

    *) Change: now the "output_buffers" directive uses two buffers by
       default.

    *) Change: now nginx limits subrequests recursion, not simultaneous
       subrequests.

    *) Change: now nginx checks the whole cache key when returning a
       response from cache.
       Thanks to Gena Makhomed and Sergey Brester.

    *) Bugfix: "header already sent" alerts might appear in logs when using
       cache; the bug had appeared in 1.7.5.

    *) Bugfix: "writev() failed (4: Interrupted system call)" errors might
       appear in logs when using CephFS and the "timer_resolution" directive
       on Linux.

    *) Bugfix: in invalid configurations handling.
       Thanks to Markus Linnala.

    *) Bugfix: a segmentation fault occurred in a worker process if the
       "sub_filter" directive was used at http level; the bug had appeared
       in 1.9.4.


Changes with nginx 1.9.4                                         18 Aug 2015

    *) Change: the "proxy_downstream_buffer" and "proxy_upstream_buffer"
       directives of the stream module are replaced with the
       "proxy_buffer_size" directive.

    *) Feature: the "tcp_nodelay" directive in the stream module.

    *) Feature: multiple "sub_filter" directives can be used simultaneously.

    *) Feature: variables support in the search string of the "sub_filter"
       directive.

    *) Workaround: configuration testing might fail under Linux OpenVZ.
       Thanks to Gena Makhomed.

    *) Bugfix: old worker processes might hog CPU after reconfiguration with
       a large number of worker_connections.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "try_files" and "alias" directives were used inside a location given
       by a regular expression; the bug had appeared in 1.7.1.

    *) Bugfix: the "try_files" directive inside a nested location given by a
       regular expression worked incorrectly if the "alias" directive was
       used in the outer location.

    *) Bugfix: in hash table initialization error handling.

    *) Bugfix: nginx could not be built with Visual Studio 2015.


Changes with nginx 1.9.3                                         14 Jul 2015

    *) Change: duplicate "http", "mail", and "stream" blocks are now
       disallowed.

    *) Feature: connection limiting in the stream module.

    *) Feature: data rate limiting in the stream module.

    *) Bugfix: the "zone" directive inside the "upstream" block did not work
       on Windows.

    *) Bugfix: compatibility with LibreSSL in the stream module.
       Thanks to Piotr Sikora.

    *) Bugfix: in the "--builddir" configure parameter.
       Thanks to Piotr Sikora.

    *) Bugfix: the "ssl_stapling_file" directive did not work; the bug had
       appeared in 1.9.2.
       Thanks to Faidon Liambotis and Brandon Black.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "ssl_stapling" directive was used; the bug had appeared in 1.9.2.
       Thanks to Matthew Baldwin.


Changes with nginx 1.9.2                                         16 Jun 2015

    *) Feature: the "backlog" parameter of the "listen" directives of the
       mail proxy and stream modules.

    *) Feature: the "allow" and "deny" directives in the stream module.

    *) Feature: the "proxy_bind" directive in the stream module.

    *) Feature: the "proxy_protocol" directive in the stream module.

    *) Feature: the -T switch.

    *) Feature: the REQUEST_SCHEME parameter added to the fastcgi.conf,
       fastcgi_params, scgi_params, and uwsgi_params standard configuration
       files.

    *) Bugfix: the "reuseport" parameter of the "listen" directive of the
       stream module did not work.

    *) Bugfix: OCSP stapling might return an expired OCSP response in some
       cases.


Changes with nginx 1.9.1                                         26 May 2015

    *) Change: now SSLv3 protocol is disabled by default.

    *) Change: some long deprecated directives are not supported anymore.

    *) Feature: the "reuseport" parameter of the "listen" directive.
       Thanks to Yingqi Lu at Intel and Sepherosa Ziehau.

    *) Feature: the $upstream_connect_time variable.

    *) Bugfix: in the "hash" directive on big-endian platforms.

    *) Bugfix: nginx might fail to start on some old Linux variants; the bug
       had appeared in 1.7.11.

    *) Bugfix: in IP address parsing.
       Thanks to Sergey Polovko.


Changes with nginx 1.9.0                                         28 Apr 2015

    *) Change: obsolete aio and rtsig event methods have been removed.

    *) Feature: the "zone" directive inside the "upstream" block.

    *) Feature: the stream module.

    *) Feature: byte ranges support in the ngx_http_memcached_module.
       Thanks to Martin Mlynář.

    *) Feature: shared memory can now be used on Windows versions with
       address space layout randomization.
       Thanks to Sergey Brester.

    *) Feature: the "error_log" directive can now be used on mail and server
       levels in mail proxy.

    *) Bugfix: the "proxy_protocol" parameter of the "listen" directive did
       not work if not specified in the first "listen" directive for a
       listen socket.


Changes with nginx 1.7.12                                        07 Apr 2015

    *) Feature: now the "tcp_nodelay" directive works with backend SSL
       connections.

    *) Feature: now thread pools can be used to read cache file headers.

    *) Bugfix: in the "proxy_request_buffering" directive.

    *) Bugfix: a segmentation fault might occur in a worker process when
       using thread pools on Linux.

    *) Bugfix: in error handling when using the "ssl_stapling" directive.
       Thanks to Filipe da Silva.

    *) Bugfix: in the ngx_http_spdy_module.


Changes with nginx 1.7.11                                        24 Mar 2015

    *) Change: the "sendfile" parameter of the "aio" directive is
       deprecated; now nginx automatically uses AIO to pre-load data for
       sendfile if both "aio" and "sendfile" directives are used.

    *) Feature: experimental thread pools support.

    *) Feature: the "proxy_request_buffering", "fastcgi_request_buffering",
       "scgi_request_buffering", and "uwsgi_request_buffering" directives.

    *) Feature: request body filters experimental API.

    *) Feature: client SSL certificates support in mail proxy.
       Thanks to Sven Peter, Franck Levionnois, and Filipe Da Silva.

    *) Feature: startup speedup when using the "hash ... consistent"
       directive in the upstream block.
       Thanks to Wai Keen Woon.

    *) Feature: debug logging into a cyclic memory buffer.

    *) Bugfix: in hash table handling.
       Thanks to Chris West.

    *) Bugfix: in the "proxy_cache_revalidate" directive.

    *) Bugfix: SSL connections might hang if deferred accept or the
       "proxy_protocol" parameter of the "listen" directive were used.
       Thanks to James Hamlin.

    *) Bugfix: the $upstream_response_time variable might contain a wrong
       value if the "image_filter" directive was used.

    *) Bugfix: in integer overflow handling.
       Thanks to Régis Leroy.

    *) Bugfix: it was not possible to enable SSLv3 with LibreSSL.

    *) Bugfix: the "ignoring stale global SSL error ... called a function
       you should not call" alerts appeared in logs when using LibreSSL.

    *) Bugfix: certificates specified by the "ssl_client_certificate" and
       "ssl_trusted_certificate" directives were inadvertently used to
       automatically construct certificate chains.


Changes with nginx 1.7.10                                        10 Feb 2015

    *) Feature: the "use_temp_path" parameter of the "proxy_cache_path",
       "fastcgi_cache_path", "scgi_cache_path", and "uwsgi_cache_path"
       directives.

    *) Feature: the $upstream_header_time variable.

    *) Workaround: now on disk overflow nginx tries to write error logs once
       a second only.

    *) Bugfix: the "try_files" directive did not ignore normal files while
       testing directories.
       Thanks to Damien Tournoud.

    *) Bugfix: alerts "sendfile() failed" if the "sendfile" directive was
       used on OS X; the bug had appeared in 1.7.8.

    *) Bugfix: alerts "sem_post() failed" might appear in logs.

    *) Bugfix: nginx could not be built with musl libc.
       Thanks to James Taylor.

    *) Bugfix: nginx could not be built on Tru64 UNIX.
       Thanks to Goetz T. Fischer.


Changes with nginx 1.7.9                                         23 Dec 2014

    *) Feature: variables support in the "proxy_cache", "fastcgi_cache",
       "scgi_cache", and "uwsgi_cache" directives.

    *) Feature: variables support in the "expires" directive.

    *) Feature: loading of secret keys from hardware tokens with OpenSSL
       engines.
       Thanks to Dmitrii Pichulin.

    *) Feature: the "autoindex_format" directive.

    *) Bugfix: cache revalidation is now only used for responses with 200
       and 206 status codes.
       Thanks to Piotr Sikora.

    *) Bugfix: the "TE" client request header line was passed to backends
       while proxying.

    *) Bugfix: the "proxy_pass", "fastcgi_pass", "scgi_pass", and
       "uwsgi_pass" directives might not work correctly inside the "if" and
       "limit_except" blocks.

    *) Bugfix: the "proxy_store" directive with the "on" parameter was
       ignored if the "proxy_store" directive with an explicitly specified
       file path was used on a previous level.

    *) Bugfix: nginx could not be built with BoringSSL.
       Thanks to Lukas Tribus.


Changes with nginx 1.7.8                                         02 Dec 2014

    *) Change: now the "If-Modified-Since", "If-Range", etc. client request
       header lines are passed to a backend while caching if nginx knows in
       advance that the response will not be cached (e.g., when using
       proxy_cache_min_uses).

    *) Change: now after proxy_cache_lock_timeout nginx sends a request to a
       backend with caching disabled; the new directives
       "proxy_cache_lock_age", "fastcgi_cache_lock_age",
       "scgi_cache_lock_age", and "uwsgi_cache_lock_age" specify a time
       after which the lock will be released and another attempt to cache a
       response will be made.

    *) Change: the "log_format" directive can now be used only at http
       level.

    *) Feature: the "proxy_ssl_certificate", "proxy_ssl_certificate_key",
       "proxy_ssl_password_file", "uwsgi_ssl_certificate",
       "uwsgi_ssl_certificate_key", and "uwsgi_ssl_password_file"
       directives.
       Thanks to Piotr Sikora.

    *) Feature: it is now possible to switch to a named location using
       "X-Accel-Redirect".
       Thanks to Toshikuni Fukaya.

    *) Feature: now the "tcp_nodelay" directive works with SPDY connections.

    *) Feature: new directives in vim syntax highliting scripts.
       Thanks to Peter Wu.

    *) Bugfix: nginx ignored the "s-maxage" value in the "Cache-Control"
       backend response header line.
       Thanks to Piotr Sikora.

    *) Bugfix: in the ngx_http_spdy_module.
       Thanks to Piotr Sikora.

    *) Bugfix: in the "ssl_password_file" directive when using OpenSSL
       0.9.8zc, 1.0.0o, 1.0.1j.

    *) Bugfix: alerts "header already sent" appeared in logs if the
       "post_action" directive was used; the bug had appeared in 1.5.4.

    *) Bugfix: alerts "the http output chain is empty" might appear in logs
       if the "postpone_output 0" directive was used with SSI includes.

    *) Bugfix: in the "proxy_cache_lock" directive with SSI subrequests.
       Thanks to Yichun Zhang.


Changes with nginx 1.7.7                                         28 Oct 2014

    *) Change: now nginx takes into account the "Vary" header line in a
       backend response while caching.

    *) Feature: the "proxy_force_ranges", "fastcgi_force_ranges",
       "scgi_force_ranges", and "uwsgi_force_ranges" directives.

    *) Feature: the "proxy_limit_rate", "fastcgi_limit_rate",
       "scgi_limit_rate", and "uwsgi_limit_rate" directives.

    *) Feature: the "Vary" parameter of the "proxy_ignore_headers",
       "fastcgi_ignore_headers", "scgi_ignore_headers", and
       "uwsgi_ignore_headers" directives.

    *) Bugfix: the last part of a response received from a backend with
       unbufferred proxy might not be sent to a client if "gzip" or "gunzip"
       directives were used.

    *) Bugfix: in the "proxy_cache_revalidate" directive.
       Thanks to Piotr Sikora.

    *) Bugfix: in error handling.
       Thanks to Yichun Zhang and Daniil Bondarev.

    *) Bugfix: in the "proxy_next_upstream_tries" and
       "proxy_next_upstream_timeout" directives.
       Thanks to Feng Gu.

    *) Bugfix: nginx/Windows could not be built with MinGW-w64 gcc.
       Thanks to Kouhei Sutou.


Changes with nginx 1.7.6                                         30 Sep 2014

    *) Change: the deprecated "limit_zone" directive is not supported
       anymore.

    *) Feature: the "limit_conn_zone" and "limit_req_zone" directives now
       can be used with combinations of multiple variables.

    *) Bugfix: request body might be transmitted incorrectly when retrying a
       FastCGI request to the next upstream server.

    *) Bugfix: in logging to syslog.


Changes with nginx 1.7.5                                         16 Sep 2014

    *) Security: it was possible to reuse SSL sessions in unrelated contexts
       if a shared SSL session cache or the same TLS session ticket key was
       used for multiple "server" blocks (CVE-2014-3616).
       Thanks to Antoine Delignat-Lavaud.

    *) Change: now the "stub_status" directive does not require a parameter.

    *) Feature: the "always" parameter of the "add_header" directive.

    *) Feature: the "proxy_next_upstream_tries",
       "proxy_next_upstream_timeout", "fastcgi_next_upstream_tries",
       "fastcgi_next_upstream_timeout", "memcached_next_upstream_tries",
       "memcached_next_upstream_timeout", "scgi_next_upstream_tries",
       "scgi_next_upstream_timeout", "uwsgi_next_upstream_tries", and
       "uwsgi_next_upstream_timeout" directives.

    *) Bugfix: in the "if" parameter of the "access_log" directive.

    *) Bugfix: in the ngx_http_perl_module.
       Thanks to Piotr Sikora.

    *) Bugfix: the "listen" directive of the mail proxy module did not allow
       to specify more than two parameters.

    *) Bugfix: the "sub_filter" directive did not work with a string to
       replace consisting of a single character.

    *) Bugfix: requests might hang if resolver was used and a timeout
       occurred during a DNS request.

    *) Bugfix: in the ngx_http_spdy_module when using with AIO.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "set" directive was used to change the "$http_...", "$sent_http_...",
       or "$upstream_http_..." variables.

    *) Bugfix: in memory allocation error handling.
       Thanks to Markus Linnala and Feng Gu.


Changes with nginx 1.7.4                                         05 Aug 2014

    *) Security: pipelined commands were not discarded after STARTTLS
       command in SMTP proxy (CVE-2014-3556); the bug had appeared in 1.5.6.
       Thanks to Chris Boulton.

    *) Change: URI escaping now uses uppercase hexadecimal digits.
       Thanks to Piotr Sikora.

    *) Feature: now nginx can be build with BoringSSL and LibreSSL.
       Thanks to Piotr Sikora.

    *) Bugfix: requests might hang if resolver was used and a DNS server
       returned a malformed response; the bug had appeared in 1.5.8.

    *) Bugfix: in the ngx_http_spdy_module.
       Thanks to Piotr Sikora.

    *) Bugfix: the $uri variable might contain garbage when returning errors
       with code 400.
       Thanks to Sergey Bobrov.

    *) Bugfix: in error handling in the "proxy_store" directive and the
       ngx_http_dav_module.
       Thanks to Feng Gu.

    *) Bugfix: a segmentation fault might occur if logging of errors to
       syslog was used; the bug had appeared in 1.7.1.

    *) Bugfix: the $geoip_latitude, $geoip_longitude, $geoip_dma_code, and
       $geoip_area_code variables might not work.
       Thanks to Yichun Zhang.

    *) Bugfix: in memory allocation error handling.
       Thanks to Tatsuhiko Kubo and Piotr Sikora.


Changes with nginx 1.7.3                                         08 Jul 2014

    *) Feature: weak entity tags are now preserved on response
       modifications, and strong ones are changed to weak.

    *) Feature: cache revalidation now uses If-None-Match header if
       possible.

    *) Feature: the "ssl_password_file" directive.

    *) Bugfix: the If-None-Match request header line was ignored if there
       was no Last-Modified header in a response returned from cache.

    *) Bugfix: "peer closed connection in SSL handshake" messages were
       logged at "info" level instead of "error" while connecting to
       backends.

    *) Bugfix: in the ngx_http_dav_module module in nginx/Windows.

    *) Bugfix: SPDY connections might be closed prematurely if caching was
       used.


Changes with nginx 1.7.2                                         17 Jun 2014

    *) Feature: the "hash" directive inside the "upstream" block.

    *) Feature: defragmentation of free shared memory blocks.
       Thanks to Wandenberg Peixoto and Yichun Zhang.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       default value of the "access_log" directive was used; the bug had
       appeared in 1.7.0.
       Thanks to Piotr Sikora.

    *) Bugfix: trailing slash was mistakenly removed from the last parameter
       of the "try_files" directive.

    *) Bugfix: nginx could not be built on OS X in some cases.

    *) Bugfix: in the ngx_http_spdy_module.


Changes with nginx 1.7.1                                         27 May 2014

    *) Feature: the "$upstream_cookie_..." variables.

    *) Feature: the $ssl_client_fingerprint variable.

    *) Feature: the "error_log" and "access_log" directives now support
       logging to syslog.

    *) Feature: the mail proxy now logs client port on connect.

    *) Bugfix: memory leak if the "ssl_stapling" directive was used.
       Thanks to Filipe da Silva.

    *) Bugfix: the "alias" directive used inside a location given by a
       regular expression worked incorrectly if the "if" or "limit_except"
       directives were used.

    *) Bugfix: the "charset" directive did not set a charset to encoded
       backend responses.

    *) Bugfix: a "proxy_pass" directive without URI part might use original
       request after the $args variable was set.
       Thanks to Yichun Zhang.

    *) Bugfix: in the "none" parameter in the "smtp_auth" directive; the bug
       had appeared in 1.5.6.
       Thanks to Svyatoslav Nikolsky.

    *) Bugfix: if sub_filter and SSI were used together, then responses
       might be transferred incorrectly.

    *) Bugfix: nginx could not be built with the --with-file-aio option on
       Linux/aarch64.


Changes with nginx 1.7.0                                         24 Apr 2014

    *) Feature: backend SSL certificate verification.

    *) Feature: support for SNI while working with SSL backends.

    *) Feature: the $ssl_server_name variable.

    *) Feature: the "if" parameter of the "access_log" directive.


Changes with nginx 1.5.13                                        08 Apr 2014

    *) Change: improved hash table handling; the default values of the
       "variables_hash_max_size" and "types_hash_bucket_size" were changed
       to 1024 and 64 respectively.

    *) Feature: the ngx_http_mp4_module now supports the "end" argument.

    *) Feature: byte ranges support in the ngx_http_mp4_module and while
       saving responses to cache.

    *) Bugfix: alerts "ngx_slab_alloc() failed: no memory" no longer logged
       when using shared memory in the "ssl_session_cache" directive and in
       the ngx_http_limit_req_module.

    *) Bugfix: the "underscores_in_headers" directive did not allow
       underscore as a first character of a header.
       Thanks to Piotr Sikora.

    *) Bugfix: cache manager might hog CPU on exit in nginx/Windows.

    *) Bugfix: nginx/Windows terminated abnormally if the
       "ssl_session_cache" directive was used with the "shared" parameter.

    *) Bugfix: in the ngx_http_spdy_module.


Changes with nginx 1.5.12                                        18 Mar 2014

    *) Security: a heap memory buffer overflow might occur in a worker
       process while handling a specially crafted request by
       ngx_http_spdy_module, potentially resulting in arbitrary code
       execution (CVE-2014-0133).
       Thanks to Lucas Molas, researcher at Programa STIC, Fundación Dr.
       Manuel Sadosky, Buenos Aires, Argentina.

    *) Feature: the "proxy_protocol" parameters of the "listen" and
       "real_ip_header" directives, the $proxy_protocol_addr variable.

    *) Bugfix: in the "fastcgi_next_upstream" directive.
       Thanks to Lucas Molas.


Changes with nginx 1.5.11                                        04 Mar 2014

    *) Security: memory corruption might occur in a worker process on 32-bit
       platforms while handling a specially crafted request by
       ngx_http_spdy_module, potentially resulting in arbitrary code
       execution (CVE-2014-0088); the bug had appeared in 1.5.10.
       Thanks to Lucas Molas, researcher at Programa STIC, Fundación Dr.
       Manuel Sadosky, Buenos Aires, Argentina.

    *) Feature: the $ssl_session_reused variable.

    *) Bugfix: the "client_max_body_size" directive might not work when
       reading a request body using chunked transfer encoding; the bug had
       appeared in 1.3.9.
       Thanks to Lucas Molas.

    *) Bugfix: a segmentation fault might occur in a worker process when
       proxying WebSocket connections.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       ngx_http_spdy_module was used on 32-bit platforms; the bug had
       appeared in 1.5.10.

    *) Bugfix: the $upstream_status variable might contain wrong data if the
       "proxy_cache_use_stale" or "proxy_cache_revalidate" directives were
       used.
       Thanks to Piotr Sikora.

    *) Bugfix: a segmentation fault might occur in a worker process if
       errors with code 400 were redirected to a named location using the
       "error_page" directive.

    *) Bugfix: nginx/Windows could not be built with Visual Studio 2013.


Changes with nginx 1.5.10                                        04 Feb 2014

    *) Feature: the ngx_http_spdy_module now uses SPDY 3.1 protocol.
       Thanks to Automattic and MaxCDN for sponsoring this work.

    *) Feature: the ngx_http_mp4_module now skips tracks too short for a
       seek requested.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       $ssl_session_id variable was used in logs; the bug had appeared in
       1.5.9.

    *) Bugfix: the $date_local and $date_gmt variables used wrong format
       outside of the ngx_http_ssi_filter_module.

    *) Bugfix: client connections might be immediately closed if deferred
       accept was used; the bug had appeared in 1.3.15.

    *) Bugfix: alerts "getsockopt(TCP_FASTOPEN) ... failed" appeared in logs
       during binary upgrade on Linux; the bug had appeared in 1.5.8.
       Thanks to Piotr Sikora.


Changes with nginx 1.5.9                                         22 Jan 2014

    *) Change: now nginx expects escaped URIs in "X-Accel-Redirect" headers.

    *) Feature: the "ssl_buffer_size" directive.

    *) Feature: the "limit_rate" directive can now be used to rate limit
       responses sent in SPDY connections.

    *) Feature: the "spdy_chunk_size" directive.

    *) Feature: the "ssl_session_tickets" directive.
       Thanks to Dirkjan Bussink.

    *) Bugfix: the $ssl_session_id variable contained full session
       serialized instead of just a session id.
       Thanks to Ivan Ristić.

    *) Bugfix: nginx incorrectly handled escaped "?" character in the
       "include" SSI command.

    *) Bugfix: the ngx_http_dav_module did not unescape destination URI of
       the COPY and MOVE methods.

    *) Bugfix: resolver did not understand domain names with a trailing dot.
       Thanks to Yichun Zhang.

    *) Bugfix: alerts "zero size buf in output" might appear in logs while
       proxying; the bug had appeared in 1.3.9.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       ngx_http_spdy_module was used.

    *) Bugfix: proxied WebSocket connections might hang right after
       handshake if the select, poll, or /dev/poll methods were used.

    *) Bugfix: the "xclient" directive of the mail proxy module incorrectly
       handled IPv6 client addresses.


Changes with nginx 1.5.8                                         17 Dec 2013

    *) Feature: IPv6 support in resolver.

    *) Feature: the "listen" directive supports the "fastopen" parameter.
       Thanks to Mathew Rodley.

    *) Feature: SSL support in the ngx_http_uwsgi_module.
       Thanks to Roberto De Ioris.

    *) Feature: vim syntax highlighting scripts were added to contrib.
       Thanks to Evan Miller.

    *) Bugfix: a timeout might occur while reading client request body in an
       SSL connection using chunked transfer encoding.

    *) Bugfix: the "master_process" directive did not work correctly in
       nginx/Windows.

    *) Bugfix: the "setfib" parameter of the "listen" directive might not
       work.

    *) Bugfix: in the ngx_http_spdy_module.


Changes with nginx 1.5.7                                         19 Nov 2013

    *) Security: a character following an unescaped space in a request line
       was handled incorrectly (CVE-2013-4547); the bug had appeared in
       0.8.41.
       Thanks to Ivan Fratric of the Google Security Team.

    *) Change: a logging level of auth_basic errors about no user/password
       provided has been lowered from "error" to "info".

    *) Feature: the "proxy_cache_revalidate", "fastcgi_cache_revalidate",
       "scgi_cache_revalidate", and "uwsgi_cache_revalidate" directives.

    *) Feature: the "ssl_session_ticket_key" directive.
       Thanks to Piotr Sikora.

    *) Bugfix: the directive "add_header Cache-Control ''" added a
       "Cache-Control" response header line with an empty value.

    *) Bugfix: the "satisfy any" directive might return 403 error instead of
       401 if auth_request and auth_basic directives were used.
       Thanks to Jan Marc Hoffmann.

    *) Bugfix: the "accept_filter" and "deferred" parameters of the "listen"
       directive were ignored for listen sockets created during binary
       upgrade.
       Thanks to Piotr Sikora.

    *) Bugfix: some data received from a backend with unbufferred proxy
       might not be sent to a client immediately if "gzip" or "gunzip"
       directives were used.
       Thanks to Yichun Zhang.

    *) Bugfix: in error handling in ngx_http_gunzip_filter_module.

    *) Bugfix: responses might hang if the ngx_http_spdy_module was used
       with the "auth_request" directive.

    *) Bugfix: memory leak in nginx/Windows.


Changes with nginx 1.5.6                                         01 Oct 2013

    *) Feature: the "fastcgi_buffering" directive.

    *) Feature: the "proxy_ssl_protocols" and "proxy_ssl_ciphers"
       directives.
       Thanks to Piotr Sikora.

    *) Feature: optimization of SSL handshakes when using long certificate
       chains.

    *) Feature: the mail proxy supports SMTP pipelining.

    *) Bugfix: in the ngx_http_auth_basic_module when using "$apr1$"
       password encryption method.
       Thanks to Markus Linnala.

    *) Bugfix: in MacOSX, Cygwin, and nginx/Windows incorrect location might
       be used to process a request if locations were given using characters
       in different cases.

    *) Bugfix: automatic redirect with appended trailing slash for proxied
       locations might not work.

    *) Bugfix: in the mail proxy server.

    *) Bugfix: in the ngx_http_spdy_module.


Changes with nginx 1.5.5                                         17 Sep 2013

    *) Change: now nginx assumes HTTP/1.0 by default if it is not able to
       detect protocol reliably.

    *) Feature: the "disable_symlinks" directive now uses O_PATH on Linux.

    *) Feature: now nginx uses EPOLLRDHUP events to detect premature
       connection close by clients if the "epoll" method is used.

    *) Bugfix: in the "valid_referers" directive if the "server_names"
       parameter was used.

    *) Bugfix: the $request_time variable did not work in nginx/Windows.

    *) Bugfix: in the "image_filter" directive.
       Thanks to Lanshun Zhou.

    *) Bugfix: OpenSSL 1.0.1f compatibility.
       Thanks to Piotr Sikora.


Changes with nginx 1.5.4                                         27 Aug 2013

    *) Change: the "js" extension MIME type has been changed to
       "application/javascript"; default value of the "charset_types"
       directive was changed accordingly.

    *) Change: now the "image_filter" directive with the "size" parameter
       returns responses with the "application/json" MIME type.

    *) Feature: the ngx_http_auth_request_module.

    *) Bugfix: a segmentation fault might occur on start or during
       reconfiguration if the "try_files" directive was used with an empty
       parameter.

    *) Bugfix: memory leak if relative paths were specified using variables
       in the "root" or "auth_basic_user_file" directives.

    *) Bugfix: the "valid_referers" directive incorrectly executed regular
       expressions if a "Referer" header started with "https://".
       Thanks to Liangbin Li.

    *) Bugfix: responses might hang if subrequests were used and an SSL
       handshake error happened during subrequest processing.
       Thanks to Aviram Cohen.

    *) Bugfix: in the ngx_http_autoindex_module.

    *) Bugfix: in the ngx_http_spdy_module.


Changes with nginx 1.5.3                                         30 Jul 2013

    *) Change in internal API: now u->length defaults to -1 if working with
       backends in unbuffered mode.

    *) Change: now after receiving an incomplete response from a backend
       server nginx tries to send an available part of the response to a
       client, and then closes client connection.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       ngx_http_spdy_module was used with the "client_body_in_file_only"
       directive.

    *) Bugfix: the "so_keepalive" parameter of the "listen" directive might
       be handled incorrectly on DragonFlyBSD.
       Thanks to Sepherosa Ziehau.

    *) Bugfix: in the ngx_http_xslt_filter_module.

    *) Bugfix: in the ngx_http_sub_filter_module.


Changes with nginx 1.5.2                                         02 Jul 2013

    *) Feature: now several "error_log" directives can be used.

    *) Bugfix: the $r->header_in() embedded perl method did not return value
       of the "Cookie" and "X-Forwarded-For" request header lines; the bug
       had appeared in 1.3.14.

    *) Bugfix: in the ngx_http_spdy_module.
       Thanks to Jim Radford.

    *) Bugfix: nginx could not be built on Linux with x32 ABI.
       Thanks to Serguei Ivantsov.


Changes with nginx 1.5.1                                         04 Jun 2013

    *) Feature: the "ssi_last_modified", "sub_filter_last_modified", and
       "xslt_last_modified" directives.
       Thanks to Alexey Kolpakov.

    *) Feature: the "http_403" parameter of the "proxy_next_upstream",
       "fastcgi_next_upstream", "scgi_next_upstream", and
       "uwsgi_next_upstream" directives.

    *) Feature: the "allow" and "deny" directives now support unix domain
       sockets.

    *) Bugfix: nginx could not be built with the ngx_mail_ssl_module, but
       without ngx_http_ssl_module; the bug had appeared in 1.3.14.

    *) Bugfix: in the "proxy_set_body" directive.
       Thanks to Lanshun Zhou.

    *) Bugfix: in the "lingering_time" directive.
       Thanks to Lanshun Zhou.

    *) Bugfix: the "fail_timeout" parameter of the "server" directive in the
       "upstream" context might not work if "max_fails" parameter was used;
       the bug had appeared in 1.3.0.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "ssl_stapling" directive was used.
       Thanks to Piotr Sikora.

    *) Bugfix: in the mail proxy server.
       Thanks to Filipe Da Silva.

    *) Bugfix: nginx/Windows might stop accepting connections if several
       worker processes were used.


Changes with nginx 1.5.0                                         07 May 2013

    *) Security: a stack-based buffer overflow might occur in a worker
       process while handling a specially crafted request, potentially
       resulting in arbitrary code execution (CVE-2013-2028); the bug had
       appeared in 1.3.9.
       Thanks to Greg MacManus, iSIGHT Partners Labs.


Changes with nginx 1.4.0                                         24 Apr 2013

    *) Bugfix: nginx could not be built with the ngx_http_perl_module if the
       --with-openssl option was used; the bug had appeared in 1.3.16.

    *) Bugfix: in a request body handling in the ngx_http_perl_module; the
       bug had appeared in 1.3.9.


Changes with nginx 1.3.16                                        16 Apr 2013

    *) Bugfix: a segmentation fault might occur in a worker process if
       subrequests were used; the bug had appeared in 1.3.9.

    *) Bugfix: the "tcp_nodelay" directive caused an error if a WebSocket
       connection was proxied into a unix domain socket.

    *) Bugfix: the $upstream_response_length variable has an incorrect value
       "0" if buffering was not used.
       Thanks to Piotr Sikora.

    *) Bugfix: in the eventport and /dev/poll methods.


Changes with nginx 1.3.15                                        26 Mar 2013

    *) Change: opening and closing a connection without sending any data in
       it is no longer logged to access_log with error code 400.

    *) Feature: the ngx_http_spdy_module.
       Thanks to Automattic for sponsoring this work.

    *) Feature: the "limit_req_status" and "limit_conn_status" directives.
       Thanks to Nick Marden.

    *) Feature: the "image_filter_interlace" directive.
       Thanks to Ian Babrou.

    *) Feature: $connections_waiting variable in the
       ngx_http_stub_status_module.

    *) Feature: the mail proxy module now supports IPv6 backends.

    *) Bugfix: request body might be transmitted incorrectly when retrying a
       request to the next upstream server; the bug had appeared in 1.3.9.
       Thanks to Piotr Sikora.

    *) Bugfix: in the "client_body_in_file_only" directive; the bug had
       appeared in 1.3.9.

    *) Bugfix: responses might hang if subrequests were used and a DNS error
       happened during subrequest processing.
       Thanks to Lanshun Zhou.

    *) Bugfix: in backend usage accounting.


Changes with nginx 1.3.14                                        05 Mar 2013

    *) Feature: $connections_active, $connections_reading, and
       $connections_writing variables in the ngx_http_stub_status_module.

    *) Feature: support of WebSocket connections in the
       ngx_http_uwsgi_module and ngx_http_scgi_module.

    *) Bugfix: in virtual servers handling with SNI.

    *) Bugfix: new sessions were not always stored if the "ssl_session_cache
       shared" directive was used and there was no free space in shared
       memory.
       Thanks to Piotr Sikora.

    *) Bugfix: multiple X-Forwarded-For headers were handled incorrectly.
       Thanks to Neal Poole for sponsoring this work.

    *) Bugfix: in the ngx_http_mp4_module.
       Thanks to Gernot Vormayr.


Changes with nginx 1.3.13                                        19 Feb 2013

    *) Change: a compiler with name "cc" is now used by default.

    *) Feature: support for proxying of WebSocket connections.
       Thanks to Apcera and CloudBees for sponsoring this work.

    *) Feature: the "auth_basic_user_file" directive supports "{SHA}"
       password encryption method.
       Thanks to Louis Opter.


Changes with nginx 1.3.12                                        05 Feb 2013

    *) Feature: variables support in the "proxy_bind", "fastcgi_bind",
       "memcached_bind", "scgi_bind", and "uwsgi_bind" directives.

    *) Feature: the $pipe, $request_length, $time_iso8601, and $time_local
       variables can now be used not only in the "log_format" directive.
       Thanks to Kiril Kalchev.

    *) Feature: IPv6 support in the ngx_http_geoip_module.
       Thanks to Gregor Kališnik.

    *) Bugfix: in the "proxy_method" directive.

    *) Bugfix: a segmentation fault might occur in a worker process if
       resolver was used with the poll method.

    *) Bugfix: nginx might hog CPU during SSL handshake with a backend if
       the select, poll, or /dev/poll methods were used.

    *) Bugfix: the "[crit] SSL_write() failed (SSL:)" error.

    *) Bugfix: in the "client_body_in_file_only" directive; the bug had
       appeared in 1.3.9.

    *) Bugfix: in the "fastcgi_keep_conn" directive.


Changes with nginx 1.3.11                                        10 Jan 2013

    *) Bugfix: a segmentation fault might occur if logging was used; the bug
       had appeared in 1.3.10.

    *) Bugfix: the "proxy_pass" directive did not work with IP addresses
       without port specified; the bug had appeared in 1.3.10.

    *) Bugfix: a segmentation fault occurred on start or during
       reconfiguration if the "keepalive" directive was specified more than
       once in a single upstream block.

    *) Bugfix: parameter "default" of the "geo" directive did not set
       default value for IPv6 addresses.


Changes with nginx 1.3.10                                        25 Dec 2012

    *) Change: domain names specified in configuration file are now resolved
       to IPv6 addresses as well as IPv4 ones.

    *) Change: now if the "include" directive with mask is used on Unix
       systems, included files are sorted in alphabetical order.

    *) Change: the "add_header" directive adds headers to 201 responses.

    *) Feature: the "geo" directive now supports IPv6 addresses in CIDR
       notation.

    *) Feature: the "flush" and "gzip" parameters of the "access_log"
       directive.

    *) Feature: variables support in the "auth_basic" directive.

    *) Bugfix: nginx could not be built with the ngx_http_perl_module in
       some cases.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       ngx_http_xslt_module was used.

    *) Bugfix: nginx could not be built on MacOSX in some cases.
       Thanks to Piotr Sikora.

    *) Bugfix: the "limit_rate" directive with high rates might result in
       truncated responses on 32-bit platforms.
       Thanks to Alexey Antropov.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "if" directive was used.
       Thanks to Piotr Sikora.

    *) Bugfix: a "100 Continue" response was issued with "413 Request Entity
       Too Large" responses.

    *) Bugfix: the "image_filter", "image_filter_jpeg_quality" and
       "image_filter_sharpen" directives might be inherited incorrectly.
       Thanks to Ian Babrou.

    *) Bugfix: "crypt_r() failed" errors might appear if the "auth_basic"
       directive was used on Linux.

    *) Bugfix: in backup servers handling.
       Thanks to Thomas Chen.

    *) Bugfix: proxied HEAD requests might return incorrect response if the
       "gzip" directive was used.


Changes with nginx 1.3.9                                         27 Nov 2012

    *) Feature: support for chunked transfer encoding while reading client
       request body.

    *) Feature: the $request_time and $msec variables can now be used not
       only in the "log_format" directive.

    *) Bugfix: cache manager and cache loader processes might not be able to
       start if more than 512 listen sockets were used.

    *) Bugfix: in the ngx_http_dav_module.


Changes with nginx 1.3.8                                         30 Oct 2012

    *) Feature: the "optional_no_ca" parameter of the "ssl_verify_client"
       directive.
       Thanks to Mike Kazantsev and Eric O'Connor.

    *) Feature: the $bytes_sent, $connection, and $connection_requests
       variables can now be used not only in the "log_format" directive.
       Thanks to Benjamin Grössing.

    *) Feature: the "auto" parameter of the "worker_processes" directive.

    *) Bugfix: "cache file ... has md5 collision" alert.

    *) Bugfix: in the ngx_http_gunzip_filter_module.

    *) Bugfix: in the "ssl_stapling" directive.


Changes with nginx 1.3.7                                         02 Oct 2012

    *) Feature: OCSP stapling support.
       Thanks to Comodo, DigiCert and GlobalSign for sponsoring this work.

    *) Feature: the "ssl_trusted_certificate" directive.

    *) Feature: resolver now randomly rotates addresses returned from cache.
       Thanks to Anton Jouline.

    *) Bugfix: OpenSSL 0.9.7 compatibility.


Changes with nginx 1.3.6                                         12 Sep 2012

    *) Feature: the ngx_http_gunzip_filter_module.

    *) Feature: the "memcached_gzip_flag" directive.

    *) Feature: the "always" parameter of the "gzip_static" directive.

    *) Bugfix: in the "limit_req" directive; the bug had appeared in 1.1.14.
       Thanks to Charles Chen.

    *) Bugfix: nginx could not be built by gcc 4.7 with -O2 optimization if
       the --with-ipv6 option was used.


Changes with nginx 1.3.5                                         21 Aug 2012

    *) Change: the ngx_http_mp4_module module no longer skips tracks in
       formats other than H.264 and AAC.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "map" directive was used with variables as values.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "geo" directive was used with the "ranges" parameter but without the
       "default" parameter; the bug had appeared in 0.8.43.
       Thanks to Zhen Chen and Weibin Yao.

    *) Bugfix: in the -p command-line parameter handling.

    *) Bugfix: in the mail proxy server.

    *) Bugfix: of minor potential bugs.
       Thanks to Coverity.

    *) Bugfix: nginx/Windows could not be built with Visual Studio 2005
       Express.
       Thanks to HAYASHI Kentaro.


Changes with nginx 1.3.4                                         31 Jul 2012

    *) Change: the "ipv6only" parameter is now turned on by default for
       listening IPv6 sockets.

    *) Feature: the Clang compiler support.

    *) Bugfix: extra listening sockets might be created.
       Thanks to Roman Odaisky.

    *) Bugfix: nginx/Windows might hog CPU if a worker process failed to
       start.
       Thanks to Ricardo Villalobos Guevara.

    *) Bugfix: the "proxy_pass_header", "fastcgi_pass_header",
       "scgi_pass_header", "uwsgi_pass_header", "proxy_hide_header",
       "fastcgi_hide_header", "scgi_hide_header", and "uwsgi_hide_header"
       directives might be inherited incorrectly.


Changes with nginx 1.3.3                                         10 Jul 2012

    *) Feature: entity tags support and the "etag" directive.

    *) Bugfix: trailing dot in a source value was not ignored if the "map"
       directive was used with the "hostnames" parameter.

    *) Bugfix: incorrect location might be used to process a request if a
       URI was changed via a "rewrite" directive before an internal redirect
       to a named location.


Changes with nginx 1.3.2                                         26 Jun 2012

    *) Change: the "single" parameter of the "keepalive" directive is now
       ignored.

    *) Change: SSL compression is now disabled when using all versions of
       OpenSSL, including ones prior to 1.0.0.

    *) Feature: it is now possible to use the "ip_hash" directive to balance
       IPv6 clients.

    *) Feature: the $status variable can now be used not only in the
       "log_format" directive.

    *) Bugfix: a segmentation fault might occur in a worker process on
       shutdown if the "resolver" directive was used.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       ngx_http_mp4_module was used.

    *) Bugfix: in the ngx_http_mp4_module.

    *) Bugfix: a segmentation fault might occur in a worker process if
       conflicting wildcard server names were used.

    *) Bugfix: nginx might be terminated abnormally on a SIGBUS signal on
       ARM platform.

    *) Bugfix: an alert "sendmsg() failed (9: Bad file number)" on HP-UX
       while reconfiguration.


Changes with nginx 1.3.1                                         05 Jun 2012

    *) Security: now nginx/Windows ignores trailing dot in URI path
       component, and does not allow URIs with ":$" in it.
       Thanks to Vladimir Kochetkov, Positive Research Center.

    *) Feature: the "proxy_pass", "fastcgi_pass", "scgi_pass", "uwsgi_pass"
       directives, and the "server" directive inside the "upstream" block,
       now support IPv6 addresses.

    *) Feature: the "resolver" directive now supports IPv6 addresses and an
       optional port specification.

    *) Feature: the "least_conn" directive inside the "upstream" block.

    *) Feature: it is now possible to specify a weight for servers while
       using the "ip_hash" directive.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "image_filter" directive was used; the bug had appeared in 1.3.0.

    *) Bugfix: nginx could not be built with ngx_cpp_test_module; the bug
       had appeared in 1.1.12.

    *) Bugfix: access to variables from SSI and embedded perl module might
       not work after reconfiguration.
       Thanks to Yichun Zhang.

    *) Bugfix: in the ngx_http_xslt_filter_module.
       Thanks to Kuramoto Eiji.

    *) Bugfix: memory leak if $geoip_org variable was used.
       Thanks to Denis F. Latypoff.

    *) Bugfix: in the "proxy_cookie_domain" and "proxy_cookie_path"
       directives.


Changes with nginx 1.3.0                                         15 May 2012

    *) Feature: the "debug_connection" directive now supports IPv6 addresses
       and the "unix:" parameter.

    *) Feature: the "set_real_ip_from" directive and the "proxy" parameter
       of the "geo" directive now support IPv6 addresses.

    *) Feature: the "real_ip_recursive", "geoip_proxy", and
       "geoip_proxy_recursive" directives.

    *) Feature: the "proxy_recursive" parameter of the "geo" directive.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "resolver" directive was used.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "fastcgi_pass", "scgi_pass", or "uwsgi_pass" directives were used and
       backend returned incorrect response.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "rewrite" directive was used and new request arguments in a
       replacement used variables.

    *) Bugfix: nginx might hog CPU if the open file resource limit was
       reached.

    *) Bugfix: nginx might loop infinitely over backends if the
       "proxy_next_upstream" directive with the "http_404" parameter was
       used and there were backup servers specified in an upstream block.

    *) Bugfix: adding the "down" parameter of the "server" directive might
       cause unneeded client redistribution among backend servers if the
       "ip_hash" directive was used.

    *) Bugfix: socket leak.
       Thanks to Yichun Zhang.

    *) Bugfix: in the ngx_http_fastcgi_module.


Changes with nginx 1.2.0                                         23 Apr 2012

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "try_files" directive was used; the bug had appeared in 1.1.19.

    *) Bugfix: response might be truncated if there were more than IOV_MAX
       buffers used.

    *) Bugfix: in the "crop" parameter of the "image_filter" directive.
       Thanks to Maxim Bublis.


Changes with nginx 1.1.19                                        12 Apr 2012

    *) Security: specially crafted mp4 file might allow to overwrite memory
       locations in a worker process if the ngx_http_mp4_module was used,
       potentially resulting in arbitrary code execution (CVE-2012-2089).
       Thanks to Matthew Daley.

    *) Bugfix: nginx/Windows might be terminated abnormally.
       Thanks to Vincent Lee.

    *) Bugfix: nginx hogged CPU if all servers in an upstream were marked as
       "backup".

    *) Bugfix: the "allow" and "deny" directives might be inherited
       incorrectly if they were used with IPv6 addresses.

    *) Bugfix: the "modern_browser" and "ancient_browser" directives might
       be inherited incorrectly.

    *) Bugfix: timeouts might be handled incorrectly on Solaris/SPARC.

    *) Bugfix: in the ngx_http_mp4_module.


Changes with nginx 1.1.18                                        28 Mar 2012

    *) Change: keepalive connections are no longer disabled for Safari by
       default.

    *) Feature: the $connection_requests variable.

    *) Feature: $tcpinfo_rtt, $tcpinfo_rttvar, $tcpinfo_snd_cwnd and
       $tcpinfo_rcv_space variables.

    *) Feature: the "worker_cpu_affinity" directive now works on FreeBSD.

    *) Feature: the "xslt_param" and "xslt_string_param" directives.
       Thanks to Samuel Behan.

    *) Bugfix: in configure tests.
       Thanks to Piotr Sikora.

    *) Bugfix: in the ngx_http_xslt_filter_module.

    *) Bugfix: nginx could not be built on Debian GNU/Hurd.


Changes with nginx 1.1.17                                        15 Mar 2012

    *) Security: content of previously freed memory might be sent to a
       client if backend returned specially crafted response.
       Thanks to Matthew Daley.

    *) Bugfix: in the embedded perl module if used from SSI.
       Thanks to Matthew Daley.

    *) Bugfix: in the ngx_http_uwsgi_module.


Changes with nginx 1.1.16                                        29 Feb 2012

    *) Change: the simultaneous subrequest limit has been raised to 200.

    *) Feature: the "from" parameter of the "disable_symlinks" directive.

    *) Feature: the "return" and "error_page" directives can now be used to
       return 307 redirections.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "resolver" directive was used and there was no "error_log" directive
       specified at global level.
       Thanks to Roman Arutyunyan.

    *) Bugfix: a segmentation fault might occur in a worker process if the
       "proxy_http_version 1.1" or "fastcgi_keep_conn on" directives were
       used.

    *) Bugfix: memory leaks.
       Thanks to Lanshun Zhou.

    *) Bugfix: in the "disable_symlinks" directive.

    *) Bugfix: on ZFS filesystem disk cache size might be calculated
       incorrectly; the bug had appeared in 1.0.1.

    *) Bugfix: nginx could not be built by the icc 12.1 compiler.

    *) Bugfix: nginx could not be built by gcc on Solaris; the bug had
       appeared in 1.1.15.


Changes with nginx 1.1.15                                        15 Feb 2012

    *) Feature: the "disable_symlinks" directive.

    *) Feature: the "proxy_cookie_domain" and "proxy_cookie_path"
       directives.

    *) Bugfix: nginx might log incorrect error "upstream prematurely closed
       connection" instead of correct "upstream sent too big header" one.
       Thanks to Feibo Li.

    *) Bugfix: nginx could not be built with the ngx_http_perl_module if the
       --with-openssl option was used.

    *) Bugfix: the number of internal redirects to named locations was not
       limited.

    *) Bugfix: calling $r->flush() multiple times might cause errors in the
       ngx_http_gzip_filter_module.

    *) Bugfix: temporary files might be not removed if the "proxy_store"
       directive was used with SSI includes.

    *) Bugfix: in some cases non-cacheable variables (such as the $args
       variable) returned old empty cached value.

    *) Bugfix: a segmentation fault might occur in a worker process if too
       many SSI subrequests were issued simultaneously; the bug had appeared
       in 0.7.25.


Changes with nginx 1.1.14                                        30 Jan 2012

    *) Feature: multiple "limit_req" limits may be used simultaneously.

    *) Bugfix: in error handling while connecting to a backend.
       Thanks to Piotr Sikora.

    *) Bugfix: in AIO error handling on FreeBSD.

    *) Bugfix: in the OpenSSL library initialization.

    *) Bugfix: the "proxy_redirect" directives might be inherited
       incorrectly.

    *) Bugfix: memory leak during reconfiguration if the "pcre_jit"
       directive was used.


Changes with nginx 1.1.13                                        16 Jan 2012

    *) Feature: the "TLSv1.1" and "TLSv1.2" parameters of the
       "ssl_protocols" directive.

    *) Bugfix: the "limit_req" directive parameters were not inherited
       correctly; the bug had appeared in 1.1.12.

    *) Bugfix: the "proxy_redirect" directive incorrectly processed
       "Refresh" header if regular expression were used.

    *) Bugfix: the "proxy_cache_use_stale" directive with "error" parameter
       did not return answer from cache if there were no live upstreams.

    *) Bugfix: the "worker_cpu_affinity" directive might not work.

    *) Bugfix: nginx could not be built on Solaris; the bug had appeared in
       1.1.12.

    *) Bugfix: in the ngx_http_mp4_module.


Changes with nginx 1.1.12                                        26 Dec 2011

    *) Change: a "proxy_pass" directive without URI part now uses changed
       URI after redirection with the "error_page" directive.
       Thanks to Lanshun Zhou.

    *) Feature: the "proxy/fastcgi/scgi/uwsgi_cache_lock",
       "proxy/fastcgi/scgi/uwsgi_cache_lock_timeout" directives.

    *) Feature: the "pcre_jit" directive.

    *) Feature: the "if" SSI command supports captures in regular
       expressions.

    *) Bugfix: the "if" SSI command did not work inside the "block" command.

    *) Bugfix: the "limit_conn_log_level" and "limit_req_log_level"
       directives might not work.

    *) Bugfix: the "limit_rate" directive did not allow to use full
       throughput, even if limit value was very high.

    *) Bugfix: the "sendfile_max_chunk" directive did not work, if the
       "limit_rate" directive was used.

    *) Bugfix: a "proxy_pass" directive without URI part always used
       original request URI if variables were used.

    *) Bugfix: a "proxy_pass" directive without URI part might use original
       request after redirection with the "try_files" directive.
       Thanks to Lanshun Zhou.

    *) Bugfix: in the ngx_http_scgi_module.

    *) Bugfix: in the ngx_http_mp4_module.

    *) Bugfix: nginx could not be built on Solaris; the bug had appeared in
       1.1.9.


Changes with nginx 1.1.11                                        12 Dec 2011

    *) Feature: the "so_keepalive" parameter of the "listen" directive.
       Thanks to Vsevolod Stakhov.

    *) Feature: the "if_not_empty" parameter of the
       "fastcgi/scgi/uwsgi_param" directives.

    *) Feature: the $https variable.

    *) Feature: the "proxy_redirect" directive supports variables in the
       first parameter.

    *) Feature: the "proxy_redirect" directive supports regular expressions.

    *) Bugfix: the $sent_http_cache_control variable might contain a wrong
       value if the "expires" directive was used.
       Thanks to Yichun Zhang.

    *) Bugfix: the "read_ahead" directive might not work combined with
       "try_files" and "open_file_cache".

    *) Bugfix: a segmentation fault might occur in a worker process if small
       time was used in the "inactive" parameter of the "proxy_cache_path"
       directive.

    *) Bugfix: responses from cache might hang.


Changes with nginx 1.1.10                                        30 Nov 2011

    *) Bugfix: a segmentation fault occurred in a worker process if AIO was
       used on Linux; the bug had appeared in 1.1.9.


Changes with nginx 1.1.9                                         28 Nov 2011

    *) Change: now double quotes are encoded in an "echo" SSI-command
       output.
       Thanks to Zaur Abasmirzoev.

    *) Feature: the "valid" parameter of the "resolver" directive. By
       default TTL returned by a DNS server is used.
       Thanks to Kirill A. Korinskiy.

    *) Bugfix: nginx might hang after a worker process abnormal termination.

    *) Bugfix: a segmentation fault might occur in a worker process if SNI
       was used; the bug had appeared in 1.1.2.

    *) Bugfix: in the "keepalive_disable" directive; the bug had appeared in
       1.1.8.
       Thanks to Alexander Usov.

    *) Bugfix: SIGWINCH signal did not work after first binary upgrade; the
       bug had appeared in 1.1.1.

    *) Bugfix: backend responses with length not matching "Content-Length"
       header line are no longer cached.

    *) Bugfix: in the "scgi_param" directive, if complex parameters were
       used.

    *) Bugfix: in the "epoll" event method.
       Thanks to Yichun Zhang.

    *) Bugfix: in the ngx_http_flv_module.
       Thanks to Piotr Sikora.

    *) Bugfix: in the ngx_http_mp4_module.

    *) Bugfix: IPv6 addresses are now handled properly in a request line and
       in a "Host" request header line.

    *) Bugfix: "add_header" and "expires" directives did not work if a
       request was proxied and response status code was 206.

    *) Bugfix: nginx could not be built on FreeBSD 10.

    *) Bugfix: nginx could not be built on AIX.


Changes with nginx 1.1.8                                         14 Nov 2011

    *) Change: the ngx_http_limit_zone_module was renamed to the
       ngx_http_limit_conn_module.

    *) Change: the "limit_zone" directive was superseded by the
       "limit_conn_zone" directive with a new syntax.

    *) Feature: support for multiple "limit_conn" limits on the same level.

    *) Feature: the "image_filter_sharpen" directive.

    *) Bugfix: a segmentation fault might occur in a worker process if
       resolver got a big DNS response.
       Thanks to Ben Hawkes.

    *) Bugfix: in cache key calculation if internal MD5 implementation was
       used; the bug had appeared in 1.0.4.

    *) Bugfix: the "If-Modified-Since", "If-Range", etc. client request
       header lines might be passed to backend while caching; or not passed
       without caching if caching was enabled in another part of the
       configuration.

    *) Bugfix: the module ngx_http_mp4_module sent incorrect
       "Content-Length" response header line if the "start" argument was
       used.
       Thanks to Piotr Sikora.


Changes with nginx 1.1.7                                         31 Oct 2011

    *) Feature: support of several DNS servers in the "resolver" directive.
       Thanks to Kirill A. Korinskiy.

    *) Bugfix: a segmentation fault occurred on start or during
       reconfiguration if the "ssl" directive was used at http level and
       there was no "ssl_certificate" defined.

    *) Bugfix: reduced memory consumption while proxying big files if they
       were buffered to disk.

    *) Bugfix: a segmentation fault might occur in a worker process if
       "proxy_http_version 1.1" directive was used.

    *) Bugfix: in the "expires @time" directive.


Changes with nginx 1.1.6                                         17 Oct 2011

    *) Change in internal API: now module context data are cleared while
       internal redirect to named location.
       Requested by Yichun Zhang.

    *) Change: if a server in an upstream failed, only one request will be
       sent to it after fail_timeout; the server will be considered alive if
       it will successfully respond to the request.

    *) Change: now the 0x7F-0xFF characters are escaped as \xXX in an
       access_log.

    *) Feature: "proxy/fastcgi/scgi/uwsgi_ignore_headers" directives support
       the following additional values: X-Accel-Limit-Rate,
       X-Accel-Buffering, X-Accel-Charset.

    *) Feature: decrease of memory consumption if SSL is used.

    *) Bugfix: some UTF-8 characters were processed incorrectly.
       Thanks to Alexey Kuts.

    *) Bugfix: the ngx_http_rewrite_module directives specified at "server"
       level were executed twice if no matching locations were defined.

    *) Bugfix: a socket leak might occurred if "aio sendfile" was used.

    *) Bugfix: connections with fast clients might be closed after
       send_timeout if file AIO was used.

    *) Bugfix: in the ngx_http_autoindex_module.

    *) Bugfix: the module ngx_http_mp4_module did not support seeking on
       32-bit platforms.


Changes with nginx 1.1.5                                         05 Oct 2011

    *) Feature: the "uwsgi_buffering" and "scgi_buffering" directives.
       Thanks to Peter Smit.

    *) Bugfix: non-cacheable responses might be cached if
       "proxy_cache_bypass" directive was used.
       Thanks to John Ferlito.

    *) Bugfix: in HTTP/1.1 support in the ngx_http_proxy_module.

    *) Bugfix: cached responses with an empty body were returned
       incorrectly; the bug had appeared in 0.8.31.

    *) Bugfix: 201 responses of the ngx_http_dav_module were incorrect; the
       bug had appeared in 0.8.32.

    *) Bugfix: in the "return" directive.

    *) Bugfix: the "ssl_session_cache builtin" directive caused segmentation
       fault; the bug had appeared in 1.1.1.


Changes with nginx 1.1.4                                         20 Sep 2011

    *) Feature: the ngx_http_upstream_keepalive module.

    *) Feature: the "proxy_http_version" directive.

    *) Feature: the "fastcgi_keep_conn" directive.

    *) Feature: the "worker_aio_requests" directive.

    *) Bugfix: if nginx was built --with-file-aio it could not be run on
       Linux kernel which did not support AIO.

    *) Bugfix: in Linux AIO error processing.
       Thanks to Hagai Avrahami.

    *) Bugfix: reduced memory consumption for long-lived requests.

    *) Bugfix: the module ngx_http_mp4_module did not support 64-bit MP4
       "co64" atom.


Changes with nginx 1.1.3                                         14 Sep 2011

    *) Feature: the module ngx_http_mp4_module.

    *) Bugfix: in Linux AIO combined with open_file_cache.

    *) Bugfix: open_file_cache did not update file info on retest if file
       was not atomically changed.

    *) Bugfix: nginx could not be built on MacOSX 10.7.


Changes with nginx 1.1.2                                         05 Sep 2011

    *) Change: now if total size of all ranges is greater than source
       response size, then nginx disables ranges and returns just the source
       response.

    *) Feature: the "max_ranges" directive.

    *) Bugfix: the "ssl_verify_client", "ssl_verify_depth", and
       "ssl_prefer_server_ciphers" directives might work incorrectly if SNI
       was used.

    *) Bugfix: in the "proxy/fastcgi/scgi/uwsgi_ignore_client_abort"
       directives.


Changes with nginx 1.1.1                                         22 Aug 2011

    *) Change: now cache loader processes either as many files as specified
       by "loader_files" parameter or works no longer than time specified by
       the "loader_threshold" parameter during each iteration.

    *) Change: now SIGWINCH signal works only in daemon mode.

    *) Feature: now shared zones and caches use POSIX semaphores on Solaris.
       Thanks to Den Ivanov.

    *) Feature: accept filters are now supported on NetBSD.

    *) Bugfix: nginx could not be built on Linux 3.0.

    *) Bugfix: nginx did not use gzipping in some cases; the bug had
       appeared in 1.1.0.

    *) Bugfix: request body might be processed incorrectly if client used
       pipelining.

    *) Bugfix: in the "request_body_in_single_buf" directive.

    *) Bugfix: in "proxy_set_body" and "proxy_pass_request_body" directives
       if SSL connection to backend was used.

    *) Bugfix: nginx hogged CPU if all servers in an upstream were marked as
       "down".

    *) Bugfix: a segmentation fault might occur during reconfiguration if
       ssl_session_cache was defined but not used in previous configuration.

    *) Bugfix: a segmentation fault might occur in a worker process if many
       backup servers were used in an upstream.

    *) Bugfix: a segmentation fault might occur in a worker process if
       "fastcgi/scgi/uwsgi_param" directives were used with values starting
       with "HTTP_"; the bug had appeared in 0.8.40.


Changes with nginx 1.1.0                                         01 Aug 2011

    *) Feature: cache loader run time decrease.

    *) Feature: "loader_files", "loader_sleep", and "loader_threshold"
       options of the "proxy/fastcgi/scgi/uwsgi_cache_path" directives.

    *) Feature: loading time decrease of configuration with large number of
       HTTPS sites.

    *) Feature: now nginx supports ECDHE key exchange ciphers.
       Thanks to Adrian Kotelba.

    *) Feature: the "lingering_close" directive.
       Thanks to Maxim Dounin.

    *) Bugfix: in closing connection for pipelined requests.
       Thanks to Maxim Dounin.

    *) Bugfix: nginx did not disable gzipping if client sent "gzip;q=0" in
       "Accept-Encoding" request header line.

    *) Bugfix: in timeout in unbuffered proxied mode.
       Thanks to Maxim Dounin.

    *) Bugfix: memory leaks when a "proxy_pass" directive contains variables
       and proxies to an HTTPS backend.
       Thanks to Maxim Dounin.

    *) Bugfix: in parameter validation of a "proxy_pass" directive with
       variables.
       Thanks to Lanshun Zhou.

    *) Bugfix: SSL did not work on QNX.
       Thanks to Maxim Dounin.

    *) Bugfix: SSL modules could not be built by gcc 4.6 without
       --with-debug option.


Changes with nginx 1.0.5                                         19 Jul 2011

    *) Change: now default SSL ciphers are "HIGH:!aNULL:!MD5".
       Thanks to Rob Stradling.

    *) Feature: the "referer_hash_max_size" and "referer_hash_bucket_size"
       directives.
       Thanks to Witold Filipczyk.

    *) Feature: $uid_reset variable.

    *) Bugfix: a segmentation fault might occur in a worker process, if a
       caching was used.
       Thanks to Lanshun Zhou.

    *) Bugfix: worker processes may got caught in an endless loop during
       reconfiguration, if a caching was used; the bug had appeared in
       0.8.48.
       Thanks to Maxim Dounin.

    *) Bugfix: "stalled cache updating" alert.
       Thanks to Maxim Dounin.


Changes with nginx 1.0.4                                         01 Jun 2011

    *) Change: now regular expressions case sensitivity in the "map"
       directive is given by prefixes "~" or "~*".

    *) Feature: now shared zones and caches use POSIX semaphores on Linux.
       Thanks to Denis F. Latypoff.

    *) Bugfix: "stalled cache updating" alert.

    *) Bugfix: nginx could not be built --without-http_auth_basic_module;
       the bug had appeared in 1.0.3.


Changes with nginx 1.0.3                                         25 May 2011

    *) Feature: the "auth_basic_user_file" directive supports "$apr1",
       "{PLAIN}", and "{SSHA}" password encryption methods.
       Thanks to Maxim Dounin.

    *) Feature: the "geoip_org" directive and $geoip_org variable.
       Thanks to Alexander Uskov, Arnaud Granal, and Denis F. Latypoff.

    *) Feature: ngx_http_geo_module and ngx_http_geoip_module support IPv4
       addresses mapped to IPv6 addresses.

    *) Bugfix: a segmentation fault occurred in a worker process during
       testing IPv4 address mapped to IPv6 address, if access or deny rules
       were defined only for IPv6; the bug had appeared in 0.8.22.

    *) Bugfix: a cached response may be broken if "proxy/fastcgi/scgi/
       uwsgi_cache_bypass" and "proxy/fastcgi/scgi/uwsgi_no_cache" directive
       values were different; the bug had appeared in 0.8.46.


Changes with nginx 1.0.2                                         10 May 2011

    *) Feature: now shared zones and caches use POSIX semaphores.

    *) Bugfix: in the "rotate" parameter of the "image_filter" directive.
       Thanks to Adam Bocim.

    *) Bugfix: nginx could not be built on Solaris; the bug had appeared in
       1.0.1.


Changes with nginx 1.0.1                                         03 May 2011

    *) Change: now the "split_clients" directive uses MurmurHash2 algorithm
       because of better distribution.
       Thanks to Oleg Mamontov.

    *) Change: now long strings starting with zero are not considered as
       false values.
       Thanks to Maxim Dounin.

    *) Change: now nginx uses a default listen backlog value 511 on Linux.

    *) Feature: the $upstream_... variables may be used in the SSI and perl
       modules.

    *) Bugfix: now nginx limits better disk cache size.
       Thanks to Oleg Mamontov.

    *) Bugfix: a segmentation fault might occur while parsing incorrect IPv4
       address; the bug had appeared in 0.9.3.
       Thanks to Maxim Dounin.

    *) Bugfix: nginx could not be built by gcc 4.6 without --with-debug
       option.

    *) Bugfix: nginx could not be built on Solaris 9 and earlier; the bug
       had appeared in 0.9.3.
       Thanks to Dagobert Michelsen.

    *) Bugfix: $request_time variable had invalid values if subrequests were
       used; the bug had appeared in 0.8.47.
       Thanks to Igor A. Valcov.


Changes with nginx 1.0.0                                         12 Apr 2011

    *) Bugfix: a cache manager might hog CPU after reload.
       Thanks to Maxim Dounin.

    *) Bugfix: an "image_filter crop" directive worked incorrectly coupled
       with an "image_filter rotate 180" directive.

    *) Bugfix: a "satisfy any" directive disabled custom 401 error page.


Changes with nginx 0.9.7                                         04 Apr 2011

    *) Feature: now keepalive connections may be closed premature, if there
       are no free worker connections.
       Thanks to Maxim Dounin.

    *) Feature: the "rotate" parameter of the "image_filter" directive.
       Thanks to Adam Bocim.

    *) Bugfix: a case when a backend in "fastcgi_pass", "scgi_pass", or
       "uwsgi_pass" directives is given by expression and refers to a
       defined upstream.


Changes with nginx 0.9.6                                         21 Mar 2011

    *) Feature: the "map" directive supports regular expressions as value of
       the first parameter.

    *) Feature: $time_iso8601 access_log variable.
       Thanks to Michael Lustfield.


Changes with nginx 0.9.5                                         21 Feb 2011

    *) Change: now nginx uses a default listen backlog value -1 on Linux.
       Thanks to Andrei Nigmatulin.

    *) Feature: the "utf8" parameter of "geoip_country" and "geoip_city"
       directives.
       Thanks to Denis F. Latypoff.

    *) Bugfix: in a default "proxy_redirect" directive if "proxy_pass"
       directive has no URI part.
       Thanks to Maxim Dounin.

    *) Bugfix: an "error_page" directive did not work with nonstandard error
       codes; the bug had appeared in 0.8.53.
       Thanks to Maxim Dounin.


Changes with nginx 0.9.4                                         21 Jan 2011

    *) Feature: the "server_name" directive supports the $hostname variable.

    *) Feature: 494 code for "Request Header Too Large" error.


Changes with nginx 0.9.3                                         13 Dec 2010

    *) Bugfix: if there was a single server for given IPv6 address:port
       pair, then captures in regular expressions in a "server_name"
       directive did not work.

    *) Bugfix: nginx could not be built on Solaris; the bug had appeared in
       0.9.0.


Changes with nginx 0.9.2                                         06 Dec 2010

    *) Feature: the "If-Unmodified-Since" client request header line
       support.

    *) Workaround: fallback to accept() syscall if accept4() was not
       implemented; the issue had appeared in 0.9.0.

    *) Bugfix: nginx could not be built on Cygwin; the bug had appeared in
       0.9.0.

    *) Bugfix: for OpenSSL vulnerability CVE-2010-4180.
       Thanks to Maxim Dounin.


Changes with nginx 0.9.1                                         30 Nov 2010

    *) Bugfix: "return CODE message" directives did not work; the bug had
       appeared in 0.9.0.


Changes with nginx 0.9.0                                         29 Nov 2010

    *) Feature: the "keepalive_disable" directive.

    *) Feature: the "map" directive supports variables as value of a defined
       variable.

    *) Feature: the "map" directive supports empty strings as value of the
       first parameter.

    *) Feature: the "map" directive supports expressions as the first
       parameter.

    *) Feature: nginx(8) manual page.
       Thanks to Sergey Osokin.

    *) Feature: Linux accept4() support.
       Thanks to Simon Liu.

    *) Workaround: elimination of Linux linker warning about "sys_errlist"
       and "sys_nerr"; the warning had appeared in 0.8.35.

    *) Bugfix: a segmentation fault might occur in a worker process, if the
       "auth_basic" directive was used.
       Thanks to Michail Laletin.

    *) Bugfix: compatibility with ngx_http_eval_module; the bug had appeared
       in 0.8.42.


Changes with nginx 0.8.53                                        18 Oct 2010

    *) Feature: now the "error_page" directive allows to change a status
       code in a redirect.

    *) Feature: the "gzip_disable" directive supports special "degradation"
       mask.

    *) Bugfix: a socket leak might occurred if file AIO was used.
       Thanks to Maxim Dounin.

    *) Bugfix: if the first server had no "listen" directive and there was
       no explicit default server, then a next server with a "listen"
       directive became the default server; the bug had appeared in 0.8.21.


Changes with nginx 0.8.52                                        28 Sep 2010

    *) Bugfix: nginx used SSL mode for a listen socket if any listen option
       was set; the bug had appeared in 0.8.51.


Changes with nginx 0.8.51                                        27 Sep 2010

    *) Change: the "secure_link_expires" directive has been canceled.

    *) Change: a logging level of resolver errors has been lowered from
       "alert" to "error".

    *) Feature: now a listen socket "ssl" parameter may be set several
       times.


Changes with nginx 0.8.50                                        02 Sep 2010

    *) Feature: the "secure_link", "secure_link_md5", and
       "secure_link_expires" directives of the ngx_http_secure_link_module.

    *) Feature: the -q switch.
       Thanks to Gena Makhomed.

    *) Bugfix: worker processes may got caught in an endless loop during
       reconfiguration, if a caching was used; the bug had appeared in
       0.8.48.

    *) Bugfix: in the "gzip_disable" directive.
       Thanks to Derrick Petzold.

    *) Bugfix: nginx/Windows could not send stop, quit, reopen, and reload
       signals to a process run in other session.


Changes with nginx 0.8.49                                        09 Aug 2010

    *) Feature: the "image_filter_jpeg_quality" directive supports
       variables.

    *) Bugfix: a segmentation fault might occur in a worker process, if the
       $geoip_region_name variables was used; the bug had appeared in
       0.8.48.

    *) Bugfix: errors intercepted by error_page were cached only for next
       request; the bug had appeared in 0.8.48.


Changes with nginx 0.8.48                                        03 Aug 2010

    *) Change: now the "server_name" directive default value is an empty
       name "".
       Thanks to Gena Makhomed.

    *) Change: now the "server_name_in_redirect" directive default value is
       "off".

    *) Feature: the $geoip_dma_code, $geoip_area_code, and
       $geoip_region_name variables.
       Thanks to Christine McGonagle.

    *) Bugfix: the "proxy_pass", "fastcgi_pass", "uwsgi_pass", and
       "scgi_pass" directives were not inherited inside "limit_except"
       blocks.

    *) Bugfix: the "proxy_cache_min_uses", "fastcgi_cache_min_uses"
       "uwsgi_cache_min_uses", and "scgi_cache_min_uses" directives did not
       work; the bug had appeared in 0.8.46.

    *) Bugfix: the "fastcgi_split_path_info" directive used incorrectly
       captures, if only parts of an URI were captured.
       Thanks to Yuriy Taraday and Frank Enderle.

    *) Bugfix: the "rewrite" directive did not escape a ";" character during
       copying from URI to query string.
       Thanks to Daisuke Murase.

    *) Bugfix: the ngx_http_image_filter_module closed a connection, if an
       image was larger than "image_filter_buffer" size.


Changes with nginx 0.8.47                                        28 Jul 2010

    *) Bugfix: $request_time variable had invalid values for subrequests.

    *) Bugfix: errors intercepted by error_page could not be cached.

    *) Bugfix: a cache manager process may got caught in an endless loop, if
       max_size parameter was used; the bug had appeared in 0.8.46.


Changes with nginx 0.8.46                                        19 Jul 2010

    *) Change: now the "proxy_no_cache", "fastcgi_no_cache",
       "uwsgi_no_cache", and "scgi_no_cache" directives affect on a cached
       response saving only.

    *) Feature: the "proxy_cache_bypass", "fastcgi_cache_bypass",
       "uwsgi_cache_bypass", and "scgi_cache_bypass" directives.

    *) Bugfix: nginx did not free memory in cache keys zones if there was an
       error during working with backend: the memory was freed only after
       inactivity time or on memory low condition.


Changes with nginx 0.8.45                                        13 Jul 2010

    *) Feature: ngx_http_xslt_filter improvements.
       Thanks to Laurence Rowe.

    *) Bugfix: SSI response might be truncated after include with
       wait="yes"; the bug had appeared in 0.7.25.
       Thanks to Maxim Dounin.

    *) Bugfix: the "listen" directive did not support the "setfib=0"
       parameter.


Changes with nginx 0.8.44                                        05 Jul 2010

    *) Change: now nginx does not cache by default backend responses, if
       they have a "Set-Cookie" header line.

    *) Feature: the "listen" directive supports the "setfib" parameter.
       Thanks to Andrew Filonov.

    *) Bugfix: the "sub_filter" directive might change character case on
       partial match.

    *) Bugfix: compatibility with HP/UX.

    *) Bugfix: compatibility with AIX xlC_r compiler.

    *) Bugfix: nginx treated large SSLv2 packets as plain requests.
       Thanks to Miroslaw Jaworski.


Changes with nginx 0.8.43                                        30 Jun 2010

    *) Feature: large geo ranges base loading speed-up.

    *) Bugfix: an error_page redirection to "location /zero {return 204;}"
       without changing status code kept the error body; the bug had
       appeared in 0.8.42.

    *) Bugfix: nginx might close IPv6 listen socket during reconfiguration.
       Thanks to Maxim Dounin.

    *) Bugfix: the $uid_set variable may be used at any request processing
       stage.


Changes with nginx 0.8.42                                        21 Jun 2010

    *) Change: now nginx tests locations given by regular expressions, if
       request was matched exactly by a location given by a prefix string.
       The previous behavior has been introduced in 0.7.1.

    *) Feature: the ngx_http_scgi_module.
       Thanks to Manlio Perillo.

    *) Feature: a text answer may be added to a "return" directive.


Changes with nginx 0.8.41                                        15 Jun 2010

    *) Security: nginx/Windows worker might be terminated abnormally if a
       requested file name has invalid UTF-8 encoding.

    *) Change: now nginx allows to use spaces in a request line.

    *) Bugfix: the "proxy_redirect" directive changed incorrectly a backend
       "Refresh" response header line.
       Thanks to Andrey Andreew and Max Sogin.

    *) Bugfix: nginx did not support path without host name in "Destination"
       request header line.


Changes with nginx 0.8.40                                        07 Jun 2010

    *) Security: now nginx/Windows ignores default file stream name.
       Thanks to Jose Antonio Vazquez Gonzalez.

    *) Feature: the ngx_http_uwsgi_module.
       Thanks to Roberto De Ioris.

    *) Feature: a "fastcgi_param" directive with value starting with "HTTP_"
       overrides a client request header line.

    *) Bugfix: the "If-Modified-Since", "If-Range", etc. client request
       header lines were passed to FastCGI-server while caching.

    *) Bugfix: listen unix domain socket could not be changed during
       reconfiguration.
       Thanks to Maxim Dounin.


Changes with nginx 0.8.39                                        31 May 2010

    *) Bugfix: an inherited "alias" directive worked incorrectly in
       inclusive location.

    *) Bugfix: in "alias" with variables and "try_files" directives
       combination.

    *) Bugfix: listen unix domain and IPv6 sockets did not inherit while
       online upgrade.
       Thanks to Maxim Dounin.


Changes with nginx 0.8.38                                        24 May 2010

    *) Feature: the "proxy_no_cache" and "fastcgi_no_cache" directives.

    *) Feature: now the "rewrite" directive does a redirect automatically if
       the $scheme variable is used.
       Thanks to Piotr Sikora.

    *) Bugfix: now "limit_req" delay directive conforms to the described
       algorithm.
       Thanks to Maxim Dounin.

    *) Bugfix: the $uid_got variable might not be used in the SSI and perl
       modules.


Changes with nginx 0.8.37                                        17 May 2010

    *) Feature: the ngx_http_split_clients_module.

    *) Feature: the "map" directive supports keys more than 255 characters.

    *) Bugfix: nginx ignored the "private" and "no-store" values in the
       "Cache-Control" backend response header line.

    *) Bugfix: a "stub" parameter of an "include" SSI directive was not
       used, if empty response has 200 status code.

    *) Bugfix: if a proxied or FastCGI request was internally redirected to
       another proxied or FastCGI location, then a segmentation fault might
       occur in a worker process; the bug had appeared in 0.8.33.
       Thanks to Yichun Zhang.

    *) Bugfix: IMAP connections may hang until they timed out while talking
       to Zimbra server.
       Thanks to Alan Batie.


Changes with nginx 0.8.36                                        22 Apr 2010

    *) Bugfix: the ngx_http_dav_module handled incorrectly the DELETE, COPY,
       and MOVE methods for symlinks.

    *) Bugfix: values of the $query_string, $arg_..., etc. variables cached
       in main request were used by the SSI module in subrequests.

    *) Bugfix: a variable value was repeatedly encoded after each an "echo"
       SSI-command output; the bug had appeared in 0.6.14.

    *) Bugfix: a worker process hung if a FIFO file was requested.
       Thanks to Vicente Aguilar and Maxim Dounin.

    *) Bugfix: OpenSSL-1.0.0 compatibility on 64-bit Linux.
       Thanks to Maxim Dounin.

    *) Bugfix: nginx could not be built --without-http-cache; the bug had
       appeared in 0.8.35.


Changes with nginx 0.8.35                                        01 Apr 2010

    *) Change: now the charset filter runs before the SSI filter.

    *) Feature: the "chunked_transfer_encoding" directive.

    *) Bugfix: an "&" character was not escaped when it was copied in
       arguments part in a rewrite rule.

    *) Bugfix: nginx might be terminated abnormally while a signal
       processing or if the directive "timer_resolution" was used on
       platforms which do not support kqueue or eventport notification
       methods.
       Thanks to George Xie and Maxim Dounin.

    *) Bugfix: if temporary files and permanent storage area resided at
       different file systems, then permanent file modification times were
       incorrect.
       Thanks to Maxim Dounin.

    *) Bugfix: ngx_http_memcached_module might issue the error message
       "memcached sent invalid trailer".
       Thanks to Maxim Dounin.

    *) Bugfix: nginx could not built zlib-1.2.4 library using the library
       sources.
       Thanks to Maxim Dounin.

    *) Bugfix: a segmentation fault occurred in a worker process, if there
       was large stderr output before FastCGI response; the bug had appeared
       in 0.8.34.
       Thanks to Maxim Dounin.


Changes with nginx 0.8.34                                        03 Mar 2010

    *) Bugfix: nginx did not support all ciphers and digests used in client
       certificates.
       Thanks to Innocenty Enikeew.

    *) Bugfix: nginx cached incorrectly FastCGI responses if there was large
       stderr output before response.

    *) Bugfix: nginx did not support HTTPS referrers.

    *) Bugfix: nginx/Windows might not find file if path in configuration
       was given in other character case; the bug had appeared in 0.8.33.

    *) Bugfix: the $date_local variable has an incorrect value, if the "%s"
       format was used.
       Thanks to Maxim Dounin.

    *) Bugfix: if ssl_session_cache was not set or was set to "none", then
       during client certificate verify the error "session id context
       uninitialized" might occur; the bug had appeared in 0.7.1.

    *) Bugfix: a geo range returned default value if the range included two
       or more /16 networks and did not begin at /16 network boundary.

    *) Bugfix: a block used in a "stub" parameter of an "include" SSI
       directive was output with "text/plain" MIME type.

    *) Bugfix: $r->sleep() did not work; the bug had appeared in 0.8.11.


Changes with nginx 0.8.33                                        01 Feb 2010

    *) Security: now nginx/Windows ignores trailing spaces in URI.
       Thanks to Dan Crowley, Core Security Technologies.

    *) Security: now nginx/Windows ignores short files names.
       Thanks to Dan Crowley, Core Security Technologies.

    *) Change: now keepalive connections after POST requests are not
       disabled for MSIE 7.0+.
       Thanks to Adam Lounds.

    *) Workaround: now keepalive connections are disabled for Safari.
       Thanks to Joshua Sierles.

    *) Bugfix: if a proxied or FastCGI request was internally redirected to
       another proxied or FastCGI location, then $upstream_response_time
       variable may have abnormally large value; the bug had appeared in
       0.8.7.

    *) Bugfix: a segmentation fault might occur in a worker process, while
       discarding a request body; the bug had appeared in 0.8.11.


Changes with nginx 0.8.32                                        11 Jan 2010

    *) Bugfix: UTF-8 encoding usage in the ngx_http_autoindex_module.
       Thanks to Maxim Dounin.

    *) Bugfix: regular expression named captures worked for two names only.
       Thanks to Maxim Dounin.

    *) Bugfix: now the "localhost" name is used in the "Host" request header
       line, if an unix domain socket is defined in the "auth_http"
       directive.
       Thanks to Maxim Dounin.

    *) Bugfix: nginx did not support chunked transfer encoding for 201
       responses.
       Thanks to Julian Reich.

    *) Bugfix: if the "expires modified" set date in the past, then a
       negative number was set in the "Cache-Control" response header line.
       Thanks to Alex Kapranoff.


Changes with nginx 0.8.31                                        23 Dec 2009

    *) Feature: now the "error_page" directive may redirect the 301 and 302
       responses.

    *) Feature: the $geoip_city_continent_code, $geoip_latitude, and
       $geoip_longitude variables.
       Thanks to Arvind Sundararajan.

    *) Feature: now the ngx_http_image_filter_module deletes always EXIF and
       other application specific data if the data consume more than 5% of a
       JPEG file.

    *) Bugfix: nginx closed a connection if a cached response had an empty
       body.
       Thanks to Piotr Sikora.

    *) Bugfix: nginx might not be built by gcc 4.x if the -O2 or higher
       optimization option was used.
       Thanks to Maxim Dounin and Denis F. Latypoff.

    *) Bugfix: regular expressions in location were always tested in
       case-sensitive mode; the bug had appeared in 0.8.25.

    *) Bugfix: nginx cached a 304 response if there was the "If-None-Match"
       header line in a proxied request.
       Thanks to Tim Dettrick and David Kostal.

    *) Bugfix: nginx/Windows tried to delete a temporary file twice if the
       file should replace an already existent file.


Changes with nginx 0.8.30                                        15 Dec 2009

    *) Change: now the default buffer size of the
       "large_client_header_buffers" directive is 8K.
       Thanks to Andrew Cholakian.

    *) Feature: the conf/fastcgi.conf for simple FastCGI configurations.

    *) Bugfix: nginx/Windows tried to rename a temporary file twice if the
       file should replace an already existent file.

    *) Bugfix: of "double free or corruption" error issued if host could not
       be resolved; the bug had appeared in 0.8.22.
       Thanks to Konstantin Svist.

    *) Bugfix: in libatomic usage on some platforms.
       Thanks to W-Mark Kubacki.


Changes with nginx 0.8.29                                        30 Nov 2009

    *) Change: now the "009" status code is written to an access log for
       proxied HTTP/0.9 responses.

    *) Feature: the "addition_types", "charset_types", "gzip_types",
       "ssi_types", "sub_filter_types", and "xslt_types" directives support
       an "*" parameter.

    *) Feature: GCC 4.1+ built-in atomic operations usage.
       Thanks to W-Mark Kubacki.

    *) Feature: the --with-libatomic[=DIR] option in the configure.
       Thanks to W-Mark Kubacki.

    *) Bugfix: listen unix domain socket had limited access rights.

    *) Bugfix: cached HTTP/0.9 responses were handled incorrectly.

    *) Bugfix: regular expression named captures given by "?P<...>" did not
       work in a "server_name" directive.
       Thanks to Maxim Dounin.


Changes with nginx 0.8.28                                        23 Nov 2009

    *) Bugfix: nginx could not be built with the --without-pcre parameter;
       the bug had appeared in 0.8.25.


Changes with nginx 0.8.27                                        17 Nov 2009

    *) Bugfix: regular expressions did not work in nginx/Windows; the bug
       had appeared in 0.8.25.


Changes with nginx 0.8.26                                        16 Nov 2009

    *) Bugfix: in captures usage in "rewrite" directive; the bug had
       appeared in 0.8.25.

    *) Bugfix: nginx could not be built without the --with-debug option; the
       bug had appeared in 0.8.25.


Changes with nginx 0.8.25                                        16 Nov 2009

    *) Change: now no message is written in an error log if a variable is
       not found by $r->variable() method.

    *) Feature: the ngx_http_degradation_module.

    *) Feature: regular expression named captures.

    *) Feature: now URI part is not required a "proxy_pass" directive if
       variables are used.

    *) Feature: now the "msie_padding" directive works for Chrome too.

    *) Bugfix: a segmentation fault occurred in a worker process on low
       memory condition; the bug had appeared in 0.8.18.

    *) Bugfix: nginx sent gzipped responses to clients those do not support
       gzip, if "gzip_static on" and "gzip_vary off"; the bug had appeared
       in 0.8.16.


Changes with nginx 0.8.24                                        11 Nov 2009

    *) Bugfix: nginx always added "Content-Encoding: gzip" response header
       line in 304 responses sent by ngx_http_gzip_static_module.

    *) Bugfix: nginx could not be built without the --with-debug option; the
       bug had appeared in 0.8.23.

    *) Bugfix: the "unix:" parameter of the "set_real_ip_from" directive
       inherited incorrectly from previous level.

    *) Bugfix: in resolving empty name.


Changes with nginx 0.8.23                                        11 Nov 2009

    *) Security: now SSL/TLS renegotiation is disabled.
       Thanks to Maxim Dounin.

    *) Bugfix: listen unix domain socket did not inherit while online
       upgrade.

    *) Bugfix: the "unix:" parameter of the "set_real_ip_from" directive did
       not without yet another directive with any IP address.

    *) Bugfix: segmentation fault and infinite looping in resolver.

    *) Bugfix: in resolver.
       Thanks to Artem Bokhan.


Changes with nginx 0.8.22                                        03 Nov 2009

    *) Feature: the "proxy_bind", "fastcgi_bind", and "memcached_bind"
       directives.

    *) Feature: the "access" and the "deny" directives support IPv6.

    *) Feature: the "set_real_ip_from" directive supports IPv6 addresses in
       request headers.

    *) Feature: the "unix:" parameter of the "set_real_ip_from" directive.

    *) Bugfix: nginx did not delete unix domain socket after configuration
       testing.

    *) Bugfix: nginx deleted unix domain socket while online upgrade.

    *) Bugfix: the "!-x" operator did not work.
       Thanks to Maxim Dounin.

    *) Bugfix: a segmentation fault might occur in a worker process, if
       limit_rate was used in HTTPS server.
       Thanks to Maxim Dounin.

    *) Bugfix: a segmentation fault might occur in a worker process while
       $limit_rate logging.
       Thanks to Maxim Dounin.

    *) Bugfix: a segmentation fault might occur in a worker process, if
       there was no "listen" directive in "server" block; the bug had
       appeared in 0.8.21.


Changes with nginx 0.8.21                                        26 Oct 2009

    *) Feature: now the "-V" switch shows TLS SNI support.

    *) Feature: the "listen" directive of the HTTP module supports unix
       domain sockets.
       Thanks to Hongli Lai.

    *) Feature: the "default_server" parameter of the "listen" directive.

    *) Feature: now a "default" parameter is not required to set listen
       socket options.

    *) Bugfix: nginx did not support dates in 2038 year on 32-bit platforms;

    *) Bugfix: socket leak; the bug had appeared in 0.8.11.


Changes with nginx 0.8.20                                        14 Oct 2009

    *) Change: now default SSL ciphers are "HIGH:!ADH:!MD5".

    *) Bugfix: the ngx_http_autoindex_module did not show the trailing slash
       in links to a directory; the bug had appeared in 0.7.15.

    *) Bugfix: nginx did not close a log file set by the --error-log-path
       configuration option; the bug had appeared in 0.7.53.

    *) Bugfix: nginx did not treat a comma as separator in the
       "Cache-Control" backend response header line.

    *) Bugfix: nginx/Windows might not create temporary file, a cache file,
       or "proxy/fastcgi_store"d file if a worker had no enough access
       rights for top level directories.

    *) Bugfix: the "Set-Cookie" and "P3P" FastCGI response header lines were
       not hidden while caching if no "fastcgi_hide_header" directives were
       used with any parameters.

    *) Bugfix: nginx counted incorrectly disk cache size.


Changes with nginx 0.8.19                                        06 Oct 2009

    *) Change: now SSLv2 protocol is disabled by default.

    *) Change: now default SSL ciphers are "ALL:!ADH:RC4+RSA:+HIGH:+MEDIUM".

    *) Bugfix: a "limit_req" directive did not work; the bug had appeared in
       0.8.18.


Changes with nginx 0.8.18                                        06 Oct 2009

    *) Feature: the "read_ahead" directive.

    *) Feature: now several "perl_modules" directives may be used.

    *) Feature: the "limit_req_log_level" and "limit_conn_log_level"
       directives.

    *) Bugfix: now "limit_req" directive conforms to the leaky bucket
       algorithm.
       Thanks to Maxim Dounin.

    *) Bugfix: nginx did not work on Linux/sparc.
       Thanks to Marcus Ramberg.

    *) Bugfix: nginx sent '\0' in a "Location" response header line on MKCOL
       request.
       Thanks to Xie Zhenye.

    *) Bugfix: zero status code was logged instead of 499 status code; the
       bug had appeared in 0.8.11.

    *) Bugfix: socket leak; the bug had appeared in 0.8.11.


Changes with nginx 0.8.17                                        28 Sep 2009

    *) Security: now "/../" are disabled in "Destination" request header
       line.

    *) Change: now $host variable value is always low case.

    *) Feature: the $ssl_session_id variable.

    *) Bugfix: socket leak; the bug had appeared in 0.8.11.


Changes with nginx 0.8.16                                        22 Sep 2009

    *) Feature: the "image_filter_transparency" directive.

    *) Bugfix: "addition_types" directive was incorrectly named
       "addtion_types".

    *) Bugfix: resolver cache poisoning.
       Thanks to Matthew Dempsky.

    *) Bugfix: memory leak in resolver.
       Thanks to Matthew Dempsky.

    *) Bugfix: invalid request line in $request variable was written in
       access_log only if error_log was set to "info" or "debug" level.

    *) Bugfix: in PNG alpha-channel support in the
       ngx_http_image_filter_module.

    *) Bugfix: nginx always added "Vary: Accept-Encoding" response header
       line, if both "gzip_static" and "gzip_vary" were on.

    *) Bugfix: in UTF-8 encoding support by "try_files" directive in
       nginx/Windows.

    *) Bugfix: in "post_action" directive usage; the bug had appeared in
       0.8.11.
       Thanks to Igor Artemiev.


Changes with nginx 0.8.15                                        14 Sep 2009

    *) Security: a segmentation fault might occur in worker process while
       specially crafted request handling.
       Thanks to Chris Ries.

    *) Bugfix: if names .domain.tld, .sub.domain.tld, and .domain-some.tld
       were defined, then the name .sub.domain.tld was matched by
       .domain.tld.

    *) Bugfix: in transparency support in the ngx_http_image_filter_module.

    *) Bugfix: in file AIO.

    *) Bugfix: in X-Accel-Redirect usage; the bug had appeared in 0.8.11.

    *) Bugfix: in embedded perl module; the bug had appeared in 0.8.11.


Changes with nginx 0.8.14                                        07 Sep 2009

    *) Bugfix: an expired cached response might stick in the "UPDATING"
       state.

    *) Bugfix: a segmentation fault might occur in worker process, if
       error_log was set to info or debug level.
       Thanks to Sergey Bochenkov.

    *) Bugfix: in embedded perl module; the bug had appeared in 0.8.11.

    *) Bugfix: an "error_page" directive did not redirect a 413 error; the
       bug had appeared in 0.6.10.


Changes with nginx 0.8.13                                        31 Aug 2009

    *) Bugfix: in the "aio sendfile" directive; the bug had appeared in
       0.8.12.

    *) Bugfix: nginx could not be built without the --with-file-aio option
       on FreeBSD; the bug had appeared in 0.8.12.


Changes with nginx 0.8.12                                        31 Aug 2009

    *) Feature: the "sendfile" parameter in the "aio" directive on FreeBSD.

    *) Bugfix: in try_files; the bug had appeared in 0.8.11.

    *) Bugfix: in memcached; the bug had appeared in 0.8.11.


Changes with nginx 0.8.11                                        28 Aug 2009

    *) Change: now directive "gzip_disable msie6" does not disable gzipping
       for MSIE 6.0 SV1.

    *) Feature: file AIO support on FreeBSD and Linux.

    *) Feature: the "directio_alignment" directive.


Changes with nginx 0.8.10                                        24 Aug 2009

    *) Bugfix: memory leaks if GeoIP City database was used.

    *) Bugfix: in copying temporary files to permanent storage area; the bug
       had appeared in 0.8.9.


Changes with nginx 0.8.9                                         17 Aug 2009

    *) Feature: now the start cache loader runs in a separate process; this
       should improve large caches handling.

    *) Feature: now temporary files and permanent storage area may reside at
       different file systems.


Changes with nginx 0.8.8                                         10 Aug 2009

    *) Bugfix: in handling FastCGI headers split in records.

    *) Bugfix: a segmentation fault occurred in worker process, if a request
       was handled in two proxied or FastCGIed locations and a caching was
       enabled in the first location; the bug had appeared in 0.8.7.


Changes with nginx 0.8.7                                         27 Jul 2009

    *) Change: minimum supported OpenSSL version is 0.9.7.

    *) Change: the "ask" parameter of the "ssl_verify_client" directive was
       changed to the "optional" parameter and now it checks a client
       certificate if it was offered.
       Thanks to Brice Figureau.

    *) Feature: the $ssl_client_verify variable.
       Thanks to Brice Figureau.

    *) Feature: the "ssl_crl" directive.
       Thanks to Brice Figureau.

    *) Feature: the "proxy" parameter of the "geo" directive.

    *) Feature: the "image_filter" directive supports variables for setting
       size.

    *) Bugfix: the $ssl_client_cert variable usage corrupted memory; the bug
       had appeared in 0.7.7.
       Thanks to Sergey Zhuravlev.

    *) Bugfix: "proxy_pass_header" and "fastcgi_pass_header" directives did
       not pass to a client the "X-Accel-Redirect", "X-Accel-Limit-Rate",
       "X-Accel-Buffering", and "X-Accel-Charset" lines from backend
       response header.
       Thanks to Maxim Dounin.

    *) Bugfix: in handling "Last-Modified" and "Accept-Ranges" backend
       response header lines; the bug had appeared in 0.7.44.
       Thanks to Maxim Dounin.

    *) Bugfix: the "[alert] zero size buf" error if subrequest returns an
       empty response; the bug had appeared in 0.8.5.


Changes with nginx 0.8.6                                         20 Jul 2009

    *) Feature: the ngx_http_geoip_module.

    *) Bugfix: XSLT filter may fail with message "not well formed XML
       document" for valid XML document.
       Thanks to Kuramoto Eiji.

    *) Bugfix: now in MacOSX, Cygwin, and nginx/Windows locations given by a
       regular expression are always tested in case insensitive mode.

    *) Bugfix: now nginx/Windows ignores trailing dots in URI.
       Thanks to Hugo Leisink.

    *) Bugfix: name of file specified in --conf-path was not honored during
       installation; the bug had appeared in 0.6.6.
       Thanks to Maxim Dounin.


Changes with nginx 0.8.5                                         13 Jul 2009

    *) Bugfix: now nginx allows underscores in a request method.

    *) Bugfix: a 500 error code was returned for invalid login/password
       while HTTP Basic authentication on Windows.

    *) Bugfix: ngx_http_perl_module responses did not work in subrequests.

    *) Bugfix: in ngx_http_limit_req_module.
       Thanks to Maxim Dounin.


Changes with nginx 0.8.4                                         22 Jun 2009

    *) Bugfix: nginx could not be built --without-http-cache; the bug had
       appeared in 0.8.3.


Changes with nginx 0.8.3                                         19 Jun 2009

    *) Feature: the $upstream_cache_status variable.

    *) Bugfix: nginx could not be built on MacOSX 10.6.

    *) Bugfix: nginx could not be built --without-http-cache; the bug had
       appeared in 0.8.2.

    *) Bugfix: a segmentation fault occurred in worker process, if a backend
       401 error was intercepted and the backend did not set the
       "WWW-Authenticate" response header line.
       Thanks to Eugene Mychlo.


Changes with nginx 0.8.2                                         15 Jun 2009

    *) Bugfix: in open_file_cache and proxy/fastcgi cache interaction on
       start up.

    *) Bugfix: open_file_cache might cache open file descriptors too long;
       the bug had appeared in 0.7.4.


Changes with nginx 0.8.1                                         08 Jun 2009

    *) Feature: the "updating" parameter in "proxy_cache_use_stale" and
       "fastcgi_cache_use_stale" directives.

    *) Bugfix: the "If-Modified-Since", "If-Range", etc. client request
       header lines were passed to backend while caching if no
       "proxy_set_header" directive was used with any parameters.

    *) Bugfix: the "Set-Cookie" and "P3P" response header lines were not
       hidden while caching if no "proxy_hide_header/fastcgi_hide_header"
       directives were used with any parameters.

    *) Bugfix: the ngx_http_image_filter_module did not support GIF87a
       format.
       Thanks to Denis Ilyinyh.

    *) Bugfix: nginx could not be built modules on Solaris 10 and early; the
       bug had appeared in 0.7.56.


Changes with nginx 0.8.0                                         02 Jun 2009

    *) Feature: the "keepalive_requests" directive.

    *) Feature: the "limit_rate_after" directive.
       Thanks to Ivan Debnar.

    *) Bugfix: XLST filter did not work in subrequests.

    *) Bugfix: in relative paths handling in nginx/Windows.

    *) Bugfix: in proxy_store, fastcgi_store, proxy_cache, and fastcgi_cache
       in nginx/Windows.

    *) Bugfix: in memory allocation error handling.
       Thanks to Maxim Dounin and Kirill A. Korinskiy.


Changes with nginx 0.7.59                                        25 May 2009

    *) Feature: the "proxy_cache_methods" and "fastcgi_cache_methods"
       directives.

    *) Bugfix: socket leak; the bug had appeared in 0.7.25.
       Thanks to Maxim Dounin.

    *) Bugfix: a segmentation fault occurred in worker process, if a request
       had no body and the $request_body variable was used;
       the bug had appeared in 0.7.58.

    *) Bugfix: the SSL modules might not built on Solaris and Linux;
       the bug had appeared in 0.7.56.

    *) Bugfix: ngx_http_xslt_filter_module responses were not handled by
       SSI, charset, and gzip filters.

    *) Bugfix: a "charset" directive did not set a charset to
       ngx_http_gzip_static_module responses.


Changes with nginx 0.7.58                                        18 May 2009

    *) Feature: a "listen" directive of the mail proxy module supports IPv6.

    *) Feature: the "image_filter_jpeg_quality" directive.

    *) Feature: the "client_body_in_single_buffer" directive.

    *) Feature: the $request_body variable.

    *) Bugfix: in ngx_http_autoindex_module in file name links having a ":"
       symbol in the name.

    *) Bugfix: "make upgrade" procedure did not work; the bug had appeared
       in 0.7.53.
       Thanks to Denis F. Latypoff.


Changes with nginx 0.7.57                                        12 May 2009

    *) Bugfix: a floating-point fault occurred in worker process, if the
       ngx_http_image_filter_module errors were redirected to named
       location; the bug had appeared in 0.7.56.


Changes with nginx 0.7.56                                        11 May 2009

    *) Feature: nginx/Windows supports IPv6 in a "listen" directive of the
       HTTP module.

    *) Bugfix: in ngx_http_image_filter_module.


Changes with nginx 0.7.55                                        06 May 2009

    *) Bugfix: the http_XXX parameters in "proxy_cache_use_stale" and
       "fastcgi_cache_use_stale" directives did not work.

    *) Bugfix: fastcgi cache did not cache header only responses.

    *) Bugfix: of "select() failed (9: Bad file descriptor)" error in
       nginx/Unix and "select() failed (10038: ...)" error in nginx/Windows.

    *) Bugfix: a segmentation fault might occur in worker process, if an
       "debug_connection" directive was used; the bug had appeared in
       0.7.54.

    *) Bugfix: fix ngx_http_image_filter_module building errors.

    *) Bugfix: the files bigger than 2G could not be transferred using
       $r->sendfile.
       Thanks to Maxim Dounin.


Changes with nginx 0.7.54                                        01 May 2009

    *) Feature: the ngx_http_image_filter_module.

    *) Feature: the "proxy_ignore_headers" and "fastcgi_ignore_headers"
       directives.

    *) Bugfix: a segmentation fault might occur in worker process, if an
       "open_file_cache_errors off" directive was used; the bug had appeared
       in 0.7.53.

    *) Bugfix: the "port_in_redirect off" directive did not work; the bug
       had appeared in 0.7.39.

    *) Bugfix: improve handling of "select" method errors.

    *) Bugfix: of "select() failed (10022: ...)" error in nginx/Windows.

    *) Bugfix: in error text descriptions in nginx/Windows; the bug had
       appeared in 0.7.53.


Changes with nginx 0.7.53                                        27 Apr 2009

    *) Change: now a log set by --error-log-path is created from the very
       start-up.

    *) Feature: now the start up errors and warnings are outputted to an
       error_log and stderr.

    *) Feature: the empty --prefix= configure parameter forces nginx to use
       a directory where it was run as prefix.

    *) Feature: the -p switch.

    *) Feature: the -s switch on Unix platforms.

    *) Feature: the -? and -h switches.
       Thanks to Jerome Loyet.

    *) Feature: now switches may be set in condensed form.

    *) Bugfix: nginx/Windows did not work if configuration file was given by
       the -c switch.

    *) Bugfix: temporary files might be not removed if the "proxy_store",
       "fastcgi_store", "proxy_cache", or "fastcgi_cache" were used.
       Thanks to Maxim Dounin.

    *) Bugfix: an incorrect value was passed to mail proxy authentication
       server in "Auth-Method" header line; the bug had appeared
       in 0.7.34.
       Thanks to Simon Lecaille.

    *) Bugfix: system error text descriptions were not logged on Linux;
       the bug had appeared in 0.7.45.

    *) Bugfix: the "fastcgi_cache_min_uses" directive did not work.
       Thanks to Andrew Vorobyoff.


Changes with nginx 0.7.52                                        20 Apr 2009

    *) Feature: the first native Windows binary release.

    *) Bugfix: in processing HEAD method while caching.

    *) Bugfix: in processing the "If-Modified-Since", "If-Range", etc.
       client request header lines while caching.

    *) Bugfix: now the "Set-Cookie" and "P3P" header lines are hidden in
       cacheable responses.

    *) Bugfix: if nginx was built with the ngx_http_perl_module and with a
       perl which supports threads, then during a master process exit the
       message "panic: MUTEX_LOCK" might be issued.

    *) Bugfix: nginx could not be built --without-http-cache; the bug had
       appeared in 0.7.48.

    *) Bugfix: nginx could not be built on platforms different from i386,
       amd64, sparc, and ppc; the bug had appeared in 0.7.42.


Changes with nginx 0.7.51                                        12 Apr 2009

    *) Feature: the "try_files" directive supports a response code in the
       fallback parameter.

    *) Feature: now any response code can be used in the "return" directive.

    *) Bugfix: the "error_page" directive made an external redirect without
       query string; the bug had appeared in 0.7.44.

    *) Bugfix: if servers listened on several defined explicitly addresses,
       then virtual servers might not work; the bug had appeared in 0.7.39.


Changes with nginx 0.7.50                                        06 Apr 2009

    *) Bugfix: the $arg_... variables did not work; the bug had appeared in
       0.7.49.


Changes with nginx 0.7.49                                        06 Apr 2009

    *) Bugfix: a segmentation fault might occur in worker process, if the
       $arg_... variables were used; the bug had appeared in 0.7.48.


Changes with nginx 0.7.48                                        06 Apr 2009

    *) Feature: the "proxy_cache_key" directive.

    *) Bugfix: now nginx takes into account the "X-Accel-Expires",
       "Expires", and "Cache-Control" header lines in a backend response.

    *) Bugfix: now nginx caches responses for the GET requests only.

    *) Bugfix: the "fastcgi_cache_key" directive was not inherited.

    *) Bugfix: the $arg_... variables did not work with SSI subrequests.
       Thanks to Maxim Dounin.

    *) Bugfix: nginx could not be built with uclibc library.
       Thanks to Timothy Redaelli.

    *) Bugfix: nginx could not be built on OpenBSD; the bug had
       appeared in 0.7.46.


Changes with nginx 0.7.47                                        01 Apr 2009

    *) Bugfix: nginx could not be built on FreeBSD 6 and early versions; the
       bug had appeared in 0.7.46.

    *) Bugfix: nginx could not be built on MacOSX; the bug had
       appeared in 0.7.46.

    *) Bugfix: if the "max_size" parameter was set, then the cache manager
       might purge a whole cache; the bug had appeared in 0.7.46.

    *) Change: a segmentation fault might occur in worker process, if the
       "proxy_cache"/"fastcgi_cache" and the "proxy_cache_valid"/
       "fastcgi_cache_valid" were set on different levels; the bug had
       appeared in 0.7.46.

    *) Bugfix: a segmentation fault might occur in worker process, if a
       request was redirected to a proxied or FastCGI server via error_page
       or try_files; the bug had appeared in 0.7.44.


Changes with nginx 0.7.46                                        30 Mar 2009

    *) Bugfix: the previous release tarball was incorrect.


Changes with nginx 0.7.45                                        30 Mar 2009

    *) Change: now the "proxy_cache" and the "proxy_cache_valid" directives
       can be set on different levels.

    *) Change: the "clean_time" parameter of the "proxy_cache_path"
       directive is canceled.

    *) Feature: the "max_size" parameter of the "proxy_cache_path"
       directive.

    *) Feature: the ngx_http_fastcgi_module preliminary cache support.

    *) Feature: now on shared memory allocation errors directive and zone
       names are logged.

    *) Bugfix: the directive "add_header last-modified ''" did not delete a
       "Last-Modified" response header line; the bug had appeared in 0.7.44.

    *) Bugfix: a relative path in the "auth_basic_user_file" directive given
       without variables did not work; the bug had appeared in 0.7.44.
       Thanks to Jerome Loyet.

    *) Bugfix: in an "alias" directive given using variables without
       references to captures of regular expressions; the bug had appeared
       in 0.7.42.


Changes with nginx 0.7.44                                        23 Mar 2009

    *) Feature: the ngx_http_proxy_module preliminary cache support.

    *) Feature: the --with-pcre option in the configure.

    *) Feature: the "try_files" directive is now allowed on the server block
       level.

    *) Bugfix: the "try_files" directive handled incorrectly a query string
       in a fallback parameter.

    *) Bugfix: the "try_files" directive might test incorrectly directories.

    *) Bugfix: if there was a single server for given address:port pair,
       then captures in regular expressions in a "server_name" directive did
       not work.


Changes with nginx 0.7.43                                        18 Mar 2009

    *) Bugfix: a request was handled incorrectly, if a "root" directive used
       variables; the bug had appeared in 0.7.42.

    *) Bugfix: if a server listened on wildcard address, then the
       $server_addr variable value was "0.0.0.0"; the bug had appeared in
       0.7.36.


Changes with nginx 0.7.42                                        16 Mar 2009

    *) Change: now the "Invalid argument" error returned by
       setsockopt(TCP_NODELAY) on Solaris, is ignored.

    *) Change: now if a file specified in a "auth_basic_user_file" directive
       is absent, then the 403 error is returned instead of the 500 one.

    *) Feature: the "auth_basic_user_file" directive supports variables.
       Thanks to Kirill A. Korinskiy.

    *) Feature: the "listen" directive supports the "ipv6only" parameter.
       Thanks to Zhang Hua.

    *) Bugfix: in an "alias" directive with references to captures of
       regular expressions; the bug had appeared in 0.7.40.

    *) Bugfix: compatibility with Tru64 UNIX.
       Thanks to Dustin Marquess.

    *) Bugfix: nginx could not be built without PCRE library; the bug had
       appeared in 0.7.41.


Changes with nginx 0.7.41                                        11 Mar 2009

    *) Bugfix: a segmentation fault might occur in worker process, if a
       "server_name" or a "location" directives had captures in regular
       expressions; the issue had appeared in 0.7.40.
       Thanks to Vladimir Sopot.


Changes with nginx 0.7.40                                        09 Mar 2009

    *) Feature: the "location" directive supports captures in regular
       expressions.

    *) Feature: an "alias" directive with capture references may be used
       inside a location given by a regular expression with captures.

    *) Feature: the "server_name" directive supports captures in regular
       expressions.

    *) Workaround: the ngx_http_autoindex_module did not show the trailing
       slash in directories on XFS filesystem; the issue had appeared in
       0.7.15.
       Thanks to Dmitry Kuzmenko.


Changes with nginx 0.7.39                                        02 Mar 2009

    *) Bugfix: large response with SSI might hang, if gzipping was enabled;
       the bug had appeared in 0.7.28.
       Thanks to Artem Bokhan.

    *) Bugfix: a segmentation fault might occur in worker process, if short
       static variants are used in a "try_files" directive.


Changes with nginx 0.7.38                                        23 Feb 2009

    *) Feature: authentication failures logging.

    *) Bugfix: name/password in auth_basic_user_file were ignored after odd
       number of empty lines.
       Thanks to Alexander Zagrebin.

    *) Bugfix: a segmentation fault occurred in a master process, if long
       path was used in unix domain socket; the bug had appeared in 0.7.36.


Changes with nginx 0.7.37                                        21 Feb 2009

    *) Bugfix: directives using upstreams did not work; the bug had appeared
       in 0.7.36.


Changes with nginx 0.7.36                                        21 Feb 2009

    *) Feature: a preliminary IPv6 support; the "listen" directive of the
       HTTP module supports IPv6.

    *) Bugfix: the $ancient_browser variable did not work for browsers
       preset by a "modern_browser" directives.


Changes with nginx 0.7.35                                        16 Feb 2009

    *) Bugfix: a "ssl_engine" directive did not use a SSL-accelerator for
       asymmetric ciphers.
       Thanks to Marcin Gozdalik.

    *) Bugfix: a "try_files" directive set MIME type depending on an
       original request extension.

    *) Bugfix: "*domain.tld" names were handled incorrectly in
       "server_name", "valid_referers", and "map" directives, if
       ".domain.tld" and ".subdomain.domain.tld" wildcards were used;
       the bug had appeared in 0.7.9.


Changes with nginx 0.7.34                                        10 Feb 2009

    *) Feature: the "off" parameter of the "if_modified_since" directive.

    *) Feature: now nginx sends an HELO/EHLO command after a XCLIENT
       command.
       Thanks to Maxim Dounin.

    *) Feature: Microsoft specific "AUTH LOGIN with User Name" mode support
       in mail proxy server.
       Thanks to Maxim Dounin.

    *) Bugfix: in a redirect rewrite directive original arguments were
       concatenated with new arguments by a "?" rather than an "&";
       the bug had appeared in 0.1.18.
       Thanks to Maxim Dounin.

    *) Bugfix: nginx could not be built on AIX.


Changes with nginx 0.7.33                                        02 Feb 2009

    *) Bugfix: a double response might be returned if the epoll or rtsig
       methods are used and a redirect was returned to a request with body.
       Thanks to Eden Li.

    *) Bugfix: the $sent_http_location variable was empty for some redirects
       types.

    *) Bugfix: a segmentation fault might occur in worker process if
       "resolver" directive was used in SMTP proxy.


Changes with nginx 0.7.32                                        26 Jan 2009

    *) Feature: now a directory existence testing can be set explicitly in
       the "try_files" directive.

    *) Bugfix: fastcgi_store stored files not always.

    *) Bugfix: in geo ranges.

    *) Bugfix: in shared memory allocations if nginx was built without
       debugging.
       Thanks to Andrey Kvasov.


Changes with nginx 0.7.31                                        19 Jan 2009

    *) Change: now the "try_files" directive tests files only and ignores
       directories.

    *) Feature: the "fastcgi_split_path_info" directive.

    *) Bugfixes in an "Expect" request header line support.

    *) Bugfixes in geo ranges.

    *) Bugfix: in a miss case ngx_http_memcached_module returned the "END"
       line as response body instead of default 404 page body; the bug had
       appeared in 0.7.18.
       Thanks to Maxim Dounin.

    *) Bugfix: while SMTP proxying nginx issued message "250 2.0.0 OK"
       instead of "235 2.0.0 OK"; the bug had appeared in 0.7.22.
       Thanks to Maxim Dounin.


Changes with nginx 0.7.30                                        24 Dec 2008

    *) Bugfix: a segmentation fault occurred in worker process, if variables
       were used in the "fastcgi_pass" or "proxy_pass" directives and host
       name must be resolved; the bug had appeared in 0.7.29.


Changes with nginx 0.7.29                                        24 Dec 2008

    *) Bugfix: the "fastcgi_pass" and "proxy_pass" directives did not
       support variables if unix domain sockets were used.

    *) Bugfixes in subrequest processing; the bugs had appeared in 0.7.25.

    *) Bugfix: a "100 Continue" response was issued for HTTP/1.0 requests;
       Thanks to Maxim Dounin.

    *) Bugfix: in memory allocation in the ngx_http_gzip_filter_module on
       Cygwin.


Changes with nginx 0.7.28                                        22 Dec 2008

    *) Change: in memory allocation in the ngx_http_gzip_filter_module.

    *) Change: the default "gzip_buffers" directive values have been changed
       to 32 4k or 16 8k from 4 4k/8k.


Changes with nginx 0.7.27                                        15 Dec 2008

    *) Feature: the "try_files" directive.

    *) Feature: variables support in the "fastcgi_pass" directive.

    *) Feature: now the $geo variable may get an address from a variable.
       Thanks to Andrei Nigmatulin.

    *) Feature: now a location's modifier may be used without space before
       name.

    *) Feature: the $upstream_response_length variable.

    *) Bugfix: now a "add_header" directive does not add an empty value.

    *) Bugfix: if zero length static file was requested, then nginx just
       closed connection; the bug had appeared in 0.7.25.

    *) Bugfix: a MOVE method could not move file in non-existent directory.

    *) Bugfix: a segmentation fault occurred in worker process, if no one
       named location was defined in server, but some one was used in an
       error_page directive.
       Thanks to Sergey Bochenkov.


Changes with nginx 0.7.26                                        08 Dec 2008

    *) Bugfix: in subrequest processing; the bug had appeared in 0.7.25.


Changes with nginx 0.7.25                                        08 Dec 2008

    *) Change: in subrequest processing.

    *) Change: now POSTs without "Content-Length" header line are allowed.

    *) Bugfix: now the "limit_req" and "limit_conn" directives log a
       prohibition reason.

    *) Bugfix: in the "delete" parameter of the "geo" directive.


Changes with nginx 0.7.24                                        01 Dec 2008

    *) Feature: the "if_modified_since" directive.

    *) Bugfix: nginx did not process a FastCGI server response, if the
       server send too many messages to stderr before response.

    *) Bugfix: the "$cookie_..." variables did not work in the SSI and the
       perl module.


Changes with nginx 0.7.23                                        27 Nov 2008

    *) Feature: the "delete" and "ranges" parameters in the "geo" directive.

    *) Feature: speeding up loading of geo base with large number of values.

    *) Feature: decrease of memory required for geo base load.


Changes with nginx 0.7.22                                        20 Nov 2008

    *) Feature: the "none" parameter in the "smtp_auth" directive.
       Thanks to Maxim Dounin.

    *) Feature: the "$cookie_..." variables.

    *) Bugfix: the "directio" directive did not work in XFS filesystem.

    *) Bugfix: the resolver did not understand big DNS responses.
       Thanks to Zyb.


Changes with nginx 0.7.21                                        11 Nov 2008

    *) Changes in the ngx_http_limit_req_module.

    *) Feature: the EXSLT support in the ngx_http_xslt_module.
       Thanks to Denis F. Latypoff.

    *) Workaround: compatibility with glibc 2.3.
       Thanks to Eric Benson and Maxim Dounin.

    *) Bugfix: nginx could not run on MacOSX 10.4 and earlier; the bug had
       appeared in 0.7.6.


Changes with nginx 0.7.20                                        10 Nov 2008

    *) Changes in the ngx_http_gzip_filter_module.

    *) Feature: the ngx_http_limit_req_module.

    *) Bugfix: worker processes might exit on a SIGBUS signal on sparc and
       ppc platforms; the bug had appeared in 0.7.3.
       Thanks to Maxim Dounin.

    *) Bugfix: the "proxy_pass http://host/some:uri" directives did not
       work; the bug had appeared in 0.7.12.

    *) Bugfix: in HTTPS mode requests might fail with the "bad write retry"
       error.

    *) Bugfix: the ngx_http_secure_link_module did not work inside
       locations, whose names are less than 3 characters.

    *) Bugfix: $server_addr variable might have no value.


Changes with nginx 0.7.19                                        13 Oct 2008

    *) Bugfix: version number update.


Changes with nginx 0.7.18                                        13 Oct 2008

    *) Change: the "underscores_in_headers" directive; now nginx does not
       allows underscores in a client request header line names.

    *) Feature: the ngx_http_secure_link_module.

    *) Feature: the "real_ip_header" directive supports any header.

    *) Feature: the "log_subrequest" directive.

    *) Feature: the $realpath_root variable.

    *) Feature: the "http_502" and "http_504" parameters of the
       "proxy_next_upstream" directive.

    *) Bugfix: the "http_503" parameter of the "proxy_next_upstream" or
       "fastcgi_next_upstream" directives did not work.

    *) Bugfix: nginx might send a "Transfer-Encoding: chunked" header line
       for HEAD requests.

    *) Bugfix: now accept threshold depends on worker_connections.


Changes with nginx 0.7.17                                        15 Sep 2008

    *) Feature: now the "directio" directive works on Linux.

    *) Feature: the $pid variable.

    *) Bugfix: the "directio" optimization that had appeared in 0.7.15 did
       not work with open_file_cache.

    *) Bugfix: the "access_log" with variables did not work on Linux; the
       bug had appeared in 0.7.7.

    *) Bugfix: the ngx_http_charset_module did not understand quoted charset
       name received from backend.


Changes with nginx 0.7.16                                        08 Sep 2008

    *) Bugfix: nginx could not be built on 64-bit platforms; the bug had
       appeared in 0.7.15.


Changes with nginx 0.7.15                                        08 Sep 2008

    *) Feature: the ngx_http_random_index_module.

    *) Feature: the "directio" directive has been optimized for file
       requests starting from arbitrary position.

    *) Feature: the "directio" directive turns off sendfile if it is
       necessary.

    *) Feature: now nginx allows underscores in a client request header line
       names.


Changes with nginx 0.7.14                                        01 Sep 2008

    *) Change: now the ssl_certificate and ssl_certificate_key directives
       have no default values.

    *) Feature: the "listen" directive supports the "ssl" parameter.

    *) Feature: now nginx takes into account a time zone change while
       reconfiguration on FreeBSD and Linux.

    *) Bugfix: the "listen" directive parameters such as "backlog",
       "rcvbuf", etc. were not set, if a default server was not the first
       one.

    *) Bugfix: if URI part captured by a "rewrite" directive was used as a
       query string, then the query string was not escaped.

    *) Bugfix: configuration file validity test improvements.


Changes with nginx 0.7.13                                        26 Aug 2008

    *) Bugfix: nginx could not be built on Linux and Solaris; the bug had
       appeared in 0.7.12.


Changes with nginx 0.7.12                                        26 Aug 2008

    *) Feature: the "server_name" directive supports empty name "".

    *) Feature: the "gzip_disable" directive supports special "msie6" mask.

    *) Bugfix: if the "max_fails=0" parameter was used in upstream with
       several servers, then a worker process exited on a SIGFPE signal.
       Thanks to Maxim Dounin.

    *) Bugfix: a request body was dropped while redirection via an
       "error_page" directive.

    *) Bugfix: a full response was returned for request method HEAD while
       redirection via an "error_page" directive.

    *) Bugfix: the $r->header_in() method did not return value of the
       "Host", "User-Agent", and "Connection" request header lines; the bug
       had appeared in 0.7.0.


Changes with nginx 0.7.11                                        18 Aug 2008

    *) Change: now ngx_http_charset_module does not work by default with
       text/css MIME type.

    *) Feature: now nginx returns the 405 status code for POST method
       requesting a static file only if the file exists.

    *) Feature: the "proxy_ssl_session_reuse" directive.

    *) Bugfix: a "proxy_pass" directive without URI part might use original
       request after the "X-Accel-Redirect" redirection was used.

    *) Bugfix: if a directory has search only rights and the first index
       file was absent, then nginx returned the 500 status code.

    *) Bugfix: in inclusive locations; the bugs had appeared in 0.7.1.


Changes with nginx 0.7.10                                        13 Aug 2008

    *) Bugfix: in the "addition_types", "charset_types", "gzip_types",
       "ssi_types", "sub_filter_types", and "xslt_types" directives; the
       bugs had appeared in 0.7.9.

    *) Bugfix: of recursive error_page for 500 status code.

    *) Bugfix: now the ngx_http_realip_module sets address not for whole
       keepalive connection, but for each request passed via the connection.


Changes with nginx 0.7.9                                         12 Aug 2008

    *) Change: now ngx_http_charset_module works by default with following
       MIME types: text/html, text/css, text/xml, text/plain,
       text/vnd.wap.wml, application/x-javascript, and application/rss+xml.

    *) Feature: the "charset_types" and "addition_types" directives.

    *) Feature: now the "gzip_types", "ssi_types", and "sub_filter_types"
       directives use hash.

    *) Feature: the ngx_cpp_test_module.

    *) Feature: the "expires" directive supports daily time.

    *) Feature: the ngx_http_xslt_module improvements and bug fixing.
       Thanks to Denis F. Latypoff and Maxim Dounin.

    *) Bugfix: the "log_not_found" directive did not work for index files
       tests.

    *) Bugfix: HTTPS connections might hang, if kqueue, epoll, rtsig, or
       eventport methods were used; the bug had appeared in 0.7.7.

    *) Bugfix: if the "server_name", "valid_referers", and "map" directives
       used an "*.domain.tld" wildcard and exact name "domain.tld" was not
       set, then the exact name was matched by the wildcard; the bug had
       appeared in 0.3.18.


Changes with nginx 0.7.8                                         04 Aug 2008

    *) Feature: the ngx_http_xslt_module.

    *) Feature: the "$arg_..." variables.

    *) Feature: Solaris directio support.
       Thanks to Ivan Debnar.

    *) Bugfix: now if FastCGI server sends a "Location" header line without
       status line, then nginx uses 302 status code.
       Thanks to Maxim Dounin.


Changes with nginx 0.7.7                                         30 Jul 2008

    *) Change: now the EAGAIN error returned by connect() is not considered
       as temporary error.

    *) Change: now the $ssl_client_cert variable value is a certificate with
       TAB character intended before each line except first one; an
       unchanged certificate is available in the $ssl_client_raw_cert
       variable.

    *) Feature: the "ask" parameter in the "ssl_verify_client" directive.

    *) Feature: byte-range processing improvements.
       Thanks to Maxim Dounin.

    *) Feature: the "directio" directive.
       Thanks to Jiang Hong.

    *) Feature: MacOSX 10.5 sendfile() support.

    *) Bugfix: now in MacOSX and Cygwin locations are tested in case
       insensitive mode; however, the compare is provided by single-byte
       locales only.

    *) Bugfix: mail proxy SSL connections hanged, if select, poll, or
       /dev/poll methods were used.

    *) Bugfix: UTF-8 encoding usage in the ngx_http_autoindex_module.


Changes with nginx 0.7.6                                         07 Jul 2008

    *) Bugfix: now if variables are used in the "access_log" directive a
       request root existence is always tested.

    *) Bugfix: the ngx_http_flv_module did not support several values in a
       query string.


Changes with nginx 0.7.5                                         01 Jul 2008

    *) Bugfixes in variables support in the "access_log" directive; the bugs
       had appeared in 0.7.4.

    *) Bugfix: nginx could not be built --without-http_gzip_module; the bug
       had appeared in 0.7.3.
       Thanks to Kirill A. Korinskiy.

    *) Bugfix: if sub_filter and SSI were used together, then responses
       might were transferred incorrectly.


Changes with nginx 0.7.4                                         30 Jun 2008

    *) Feature: variables support in the "access_log" directive.

    *) Feature: the "open_log_file_cache" directive.

    *) Feature: the -g switch.

    *) Feature: the "Expect" request header line support.

    *) Bugfix: large SSI inclusions might be truncated.


Changes with nginx 0.7.3                                         23 Jun 2008

    *) Change: the "rss" extension MIME type has been changed to
       "application/rss+xml".

    *) Change: now the "gzip_vary" directive turned on issues a
       "Vary: Accept-Encoding" header line for uncompressed responses too.

    *) Feature: now the "rewrite" directive does a redirect automatically if
       the "https://" protocol is used.

    *) Bugfix: the "proxy_pass" directive did not work with the HTTPS
       protocol; the bug had appeared in 0.6.9.


Changes with nginx 0.7.2                                         16 Jun 2008

    *) Feature: now nginx supports EDH key exchange ciphers.

    *) Feature: the "ssl_dhparam" directive.

    *) Feature: the $ssl_client_cert variable.
       Thanks to Manlio Perillo.

    *) Bugfix: after changing URI via a "rewrite" directive nginx did not
       search a new location; the bug had appeared in 0.7.1.
       Thanks to Maxim Dounin.

    *) Bugfix: nginx could not be built without PCRE library; the bug had
       appeared in 0.7.1.

    *) Bugfix: when a request to a directory was redirected with the slash
       added, nginx dropped a query string from the original request.


Changes with nginx 0.7.1                                         26 May 2008

    *) Change: now locations are searched in a tree.

    *) Change: the "optimize_server_names" directive was canceled due to the
       "server_name_in_redirect" directive introduction.

    *) Change: some long deprecated directives are not supported anymore.

    *) Change: the "none" parameter in the "ssl_session_cache" directive;
       now this is default parameter.
       Thanks to Rob Mueller.

    *) Bugfix: worker processes might not catch reconfiguration and log
       rotation signals.

    *) Bugfix: nginx could not be built on latest Fedora 9 Linux.
       Thanks to Roxis.


Changes with nginx 0.7.0                                         19 May 2008

    *) Change: now the 0x00-0x1F, '"' and '\' characters are escaped as \xXX
       in an access_log.
       Thanks to Maxim Dounin.

    *) Change: now nginx allows several "Host" request header line.

    *) Feature: the "modified" flag in the "expires" directive.

    *) Feature: the $uid_got and $uid_set variables may be used at any
       request processing stage.

    *) Feature: the $hostname variable.
       Thanks to Andrei Nigmatulin.

    *) Feature: DESTDIR support.
       Thanks to Todd A. Fisher and Andras Voroskoi.

    *) Bugfix: a segmentation fault might occur in worker process on Linux,
       if keepalive was enabled.


Changes with nginx 0.6.31                                        12 May 2008

    *) Bugfix: nginx did not process FastCGI response if header was at the
       end of FastCGI record; the bug had appeared in 0.6.2.
       Thanks to Sergey Serov.

    *) Bugfix: a segmentation fault might occur in worker process if a file
       was deleted and the "open_file_cache_errors" directive was off.


Changes with nginx 0.6.30                                        29 Apr 2008

    *) Change: now if an "include" directive pattern does not match any
       file, then nginx does not issue an error.

    *) Feature: now the time in directives may be specified without spaces,
       for example, "1h50m".

    *) Bugfix: memory leaks if the "ssl_verify_client" directive was on.
       Thanks to Chavelle Vincent.

    *) Bugfix: the "sub_filter" directive might set text to change into
       output.

    *) Bugfix: the "error_page" directive did not take into account
       arguments in redirected URI.

    *) Bugfix: now nginx always opens files in binary mode under Cygwin.

    *) Bugfix: nginx could not be built on OpenBSD; the bug had appeared in
       0.6.15.


Changes with nginx 0.6.29                                        18 Mar 2008

    *) Feature: the ngx_google_perftools_module.

    *) Bugfix: the ngx_http_perl_module could not be built on 64-bit
       platforms; the bug had appeared in 0.6.27.


Changes with nginx 0.6.28                                        13 Mar 2008

    *) Bugfix: the rtsig method could not be built; the bug had appeared in
       0.6.27.


Changes with nginx 0.6.27                                        12 Mar 2008

    *) Change: now by default the rtsig method is not built on
       Linux 2.6.18+.

    *) Change: now a request method is not changed while redirection to a
       named location via an "error_page" directive.

    *) Feature: the "resolver" and "resolver_timeout" directives in SMTP
       proxy.

    *) Feature: the "post_action" directive supports named locations.

    *) Bugfix: a segmentation fault occurred in worker process, if a request
       was redirected from proxy, FastCGI, or memcached location to static
       named locations.

    *) Bugfix: browsers did not repeat SSL handshake if there is no valid
       client certificate in first handshake.
       Thanks to Alexander V. Inyukhin.

    *) Bugfix: if response code 495-497 was redirected via an "error_page"
       directive without code change, then nginx tried to allocate too many
       memory.

    *) Bugfix: memory leak in long-lived non buffered connections.

    *) Bugfix: memory leak in resolver.

    *) Bugfix: a segmentation fault occurred in worker process, if a request
       was redirected from proxy, FastCGI, or memcached location to static
       named locations.

    *) Bugfix: in the $proxy_host and $proxy_port variables caching.
       Thanks to Sergey Bochenkov.

    *) Bugfix: a "proxy_pass" directive with variables used incorrectly the
       same port as in another "proxy_pass" directive with the same host
       name and without variables.
       Thanks to Sergey Bochenkov.

    *) Bugfix: an alert "sendmsg() failed (9: Bad file descriptor)" on some
       64-bit platforms while reconfiguration.

    *) Bugfix: a segmentation fault occurred in worker process, if empty
       stub block was used second time in SSI.

    *) Bugfix: in copying URI part contained escaped symbols into arguments.


Changes with nginx 0.6.26                                        11 Feb 2008

    *) Bugfix: the "proxy_store" and "fastcgi_store" directives did not
       check a response length.

    *) Bugfix: a segmentation fault occurred in worker process, if big value
       was used in a "expires" directive.
       Thanks to Joaquin Cuenca Abela.

    *) Bugfix: nginx incorrectly detected cache line size on Pentium 4.
       Thanks to Gena Makhomed.

    *) Bugfix: in proxied or FastCGI subrequests a client original method
       was used instead of the GET method.

    *) Bugfix: socket leak in HTTPS mode if deferred accept was used.
       Thanks to Ben Maurer.

    *) Bugfix: nginx issued the bogus error message "SSL_shutdown() failed
       (SSL: )"; the bug had appeared in 0.6.23.

    *) Bugfix: in HTTPS mode requests might fail with the "bad write retry"
       error; the bug had appeared in 0.6.23.


Changes with nginx 0.6.25                                        08 Jan 2008

    *) Change: now the "server_name_in_redirect" directive is used instead
       of the "server_name" directive's special "*" parameter.

    *) Change: now wildcard and regex names can be used as main name in a
       "server_name" directive.

    *) Change: the "satisfy_any" directive was replaced by the "satisfy"
       directive.

    *) Workaround: old worker processes might hog CPU after reconfiguration
       if they was run under Linux OpenVZ.

    *) Feature: the "min_delete_depth" directive.

    *) Bugfix: the COPY and MOVE methods did not work with single files.

    *) Bugfix: the ngx_http_gzip_static_module did not allow the
       ngx_http_dav_module to work; the bug had appeared in 0.6.23.

    *) Bugfix: socket leak in HTTPS mode if deferred accept was used.
       Thanks to Ben Maurer.

    *) Bugfix: nginx could not be built without PCRE library; the bug had
       appeared in 0.6.23.


Changes with nginx 0.6.24                                        27 Dec 2007

    *) Bugfix: a segmentation fault might occur in worker process if HTTPS
       was used; the bug had appeared in 0.6.23.


Changes with nginx 0.6.23                                        27 Dec 2007

    *) Change: the "off" parameter in the "ssl_session_cache" directive; now
       this is default parameter.

    *) Change: the "open_file_cache_retest" directive was renamed to the
       "open_file_cache_valid".

    *) Feature: the "open_file_cache_min_uses" directive.

    *) Feature: the ngx_http_gzip_static_module.

    *) Feature: the "gzip_disable" directive.

    *) Feature: the "memcached_pass" directive may be used inside the "if"
       block.

    *) Bugfix: a segmentation fault occurred in worker process, if the
       "memcached_pass" and "if" directives were used in the same location.

    *) Bugfix: if a "satisfy_any on" directive was used and not all access
       and auth modules directives were set, then other given access and
       auth directives were not tested;

    *) Bugfix: regex parameters in a "valid_referers" directive were not
       inherited from previous level.

    *) Bugfix: a "post_action" directive did run if a request was completed
       with 499 status code.

    *) Bugfix: optimization of 16K buffer usage in a SSL connection.
       Thanks to Ben Maurer.

    *) Bugfix: the STARTTLS in SMTP mode did not work.
       Thanks to Oleg Motienko.

    *) Bugfix: in HTTPS mode requests might fail with the "bad write retry"
       error; the bug had appeared in 0.5.13.


Changes with nginx 0.6.22                                        19 Dec 2007

    *) Change: now all ngx_http_perl_module methods return values copied to
       perl's allocated memory.

    *) Bugfix: if nginx was built with ngx_http_perl_module, the perl before
       5.8.6 was used, and perl supported threads, then during
       reconfiguration the master process aborted; the bug had appeared in
       0.5.9.
       Thanks to Boris Zhmurov.

    *) Bugfix: the ngx_http_perl_module methods may get invalid values of
       the regex captures.

    *) Bugfix: a segmentation fault occurred in worker process, if the
       $r->has_request_body() method was called for a request whose small
       request body was already received.

    *) Bugfix: large_client_header_buffers did not freed before going to
       keep-alive state.
       Thanks to Olexander Shtepa.

    *) Bugfix: the last address was missed in the $upstream_addr variable;
       the bug had appeared in 0.6.18.

    *) Bugfix: the "fastcgi_catch_stderr" directive did return error code;
       now it returns 502 code, that can be rerouted to a next server using
       the "fastcgi_next_upstream invalid_header" directive.

    *) Bugfix: a segmentation fault occurred in master process if the
       "fastcgi_catch_stderr" directive was used; the bug had appeared in
       0.6.10.
       Thanks to Manlio Perillo.


Changes with nginx 0.6.21                                        03 Dec 2007

    *) Change: if variable values used in a "proxy_pass" directive contain
       IP-addresses only, then a "resolver" directive is not mandatory.

    *) Bugfix: a segmentation fault might occur in worker process if a
       "proxy_pass" directive with URI-part was used; the bug had appeared
       in 0.6.19.

    *) Bugfix: if resolver was used on platform that does not support
       kqueue, then nginx issued an alert "name is out of response".
       Thanks to Andrei Nigmatulin.

    *) Bugfix: if the $server_protocol was used in FastCGI parameters and a
       request line length was near to the "client_header_buffer_size"
       directive value, then nginx issued an alert "fastcgi: the request
       record is too big".

    *) Bugfix: if a plain text HTTP/0.9 version request was made to HTTPS
       server, then nginx returned usual response.


Changes with nginx 0.6.20                                        28 Nov 2007

    *) Bugfix: a segmentation fault might occur in worker process if a
       "proxy_pass" directive with URI-part was used; the bug had appeared
       in 0.6.19.


Changes with nginx 0.6.19                                        27 Nov 2007

    *) Bugfix: the 0.6.18 version could not be built.


Changes with nginx 0.6.18                                        27 Nov 2007

    *) Change: now the ngx_http_userid_module adds start time microseconds
       to the cookie field contains a pid value.

    *) Change: now the full request line instead of URI only is written to
       error_log.

    *) Feature: variables support in the "proxy_pass" directive.

    *) Feature: the "resolver" and "resolver_timeout" directives.

    *) Feature: now the directive "add_header last-modified ''" deletes a
       "Last-Modified" response header line.

    *) Bugfix: the "limit_rate" directive did not allow to use full
       throughput, even if limit value was very high.


Changes with nginx 0.6.17                                        15 Nov 2007

    *) Feature: the "If-Range" request header line support.
       Thanks to Alexander V. Inyukhin.

    *) Bugfix: URL double escaping in a redirect of the "msie_refresh"
       directive; the bug had appeared in 0.6.4.

    *) Bugfix: the "autoindex" directive did not work with the "alias /"
       directive.

    *) Bugfix: a segmentation fault might occur in worker process if
       subrequests were used.

    *) Bugfix: the big responses may be transferred truncated if SSL and
       gzip were used.

    *) Bugfix: the $status variable was equal to 0 if a proxied server
       returned response in HTTP/0.9 version.


Changes with nginx 0.6.16                                        29 Oct 2007

    *) Change: now the uname(2) is used on Linux instead of procfs.
       Thanks to Ilya Novikov.

    *) Bugfix: if the "?" character was in a "error_page" directive, then it
       was escaped in a proxied request; the bug had appeared in 0.6.11.

    *) Bugfix: compatibility with mget.


Changes with nginx 0.6.15                                        22 Oct 2007

    *) Feature: Cygwin compatibility.
       Thanks to Vladimir Kutakov.

    *) Feature: the "merge_slashes" directive.

    *) Feature: the "gzip_vary" directive.

    *) Feature: the "server_tokens" directive.

    *) Bugfix: nginx did not unescape URI in the "include" SSI command.

    *) Bugfix: the segmentation fault was occurred on start or while
       reconfiguration if variable was used in the "charset" or
       "source_charset" directives.

    *) Bugfix: nginx returned the 400 response on requests like
       "GET http://www.domain.com HTTP/1.0".
       Thanks to James Oakley.

    *) Bugfix: if request with request body was redirected using the
       "error_page" directive, then nginx tried to read the request body
       again; the bug had appeared in 0.6.7.

    *) Bugfix: a segmentation fault occurred in worker process if no
       server_name was explicitly defined for server processing request; the
       bug had appeared in 0.6.7.


Changes with nginx 0.6.14                                        15 Oct 2007

    *) Change: now by default the "echo" SSI command uses entity encoding.

    *) Feature: the "encoding" parameter in the "echo" SSI command.

    *) Feature: the "access_log" directive may be used inside the
       "limit_except" block.

    *) Bugfix: if all upstream servers were failed, then all servers had got
       weight the was equal one until servers became alive; the bug had
       appeared in 0.6.6.

    *) Bugfix: a segmentation fault occurred in worker process if
       $date_local and $date_gmt were used outside the
       ngx_http_ssi_filter_module.

    *) Bugfix: a segmentation fault might occur in worker process if debug
       log was enabled.
       Thanks to Andrei Nigmatulin.

    *) Bugfix: ngx_http_memcached_module did not set
       $upstream_response_time.
       Thanks to Maxim Dounin.

    *) Bugfix: a worker process may got caught in an endless loop, if the
       memcached was used.

    *) Bugfix: nginx supported low case only "close" and "keep-alive" values
       in the "Connection" request header line; the bug had appeared in
       0.6.11.

    *) Bugfix: sub_filter did not work with empty substitution.

    *) Bugfix: in sub_filter parsing.


Changes with nginx 0.6.13                                        24 Sep 2007

    *) Bugfix: nginx did not close directory file on HEAD request if
       autoindex was used.
       Thanks to Arkadiusz Patyk.


Changes with nginx 0.6.12                                        21 Sep 2007

    *) Change: mail proxy was split on three modules: pop3, imap and smtp.

    *) Feature: the --without-mail_pop3_module, --without-mail_imap_module,
       and --without-mail_smtp_module configuration parameters.

    *) Feature: the "smtp_greeting_delay" and "smtp_client_buffer"
       directives of the ngx_mail_smtp_module.

    *) Bugfix: the trailing wildcards did not work; the bug had appeared in
       0.6.9.

    *) Bugfix: nginx could not start on Solaris if the shared PCRE library
       located in non-standard place was used.

    *) Bugfix: the "proxy_hide_header" and "fastcgi_hide_header" directives
       did not hide response header lines whose name was longer than 32
       characters.
       Thanks to Manlio Perillo.


Changes with nginx 0.6.11                                        11 Sep 2007

    *) Bugfix: active connection counter always increased if mail proxy was
       used.

    *) Bugfix: if backend returned response header only using non-buffered
       proxy, then nginx closed backend connection on timeout.

    *) Bugfix: nginx did not support several "Connection" request header
       lines.

    *) Bugfix: if the "max_fails" was set for upstream server, then after
       first failure server weight was always one; the bug had appeared in
       0.6.6.


Changes with nginx 0.6.10                                        03 Sep 2007

    *) Feature: the "open_file_cache", "open_file_cache_retest", and
       "open_file_cache_errors" directives.

    *) Bugfix: socket leak; the bug had appeared in 0.6.7.

    *) Bugfix: a charset set by the "charset" directive was not appended to
       the "Content-Type" header set by $r->send_http_header().

    *) Bugfix: a segmentation fault might occur in worker process if
       /dev/poll method was used.


Changes with nginx 0.6.9                                         28 Aug 2007

    *) Bugfix: a worker process may got caught in an endless loop, if the
       HTTPS protocol was used; the bug had appeared in 0.6.7.

    *) Bugfix: if server listened on two addresses or ports and trailing
       wildcard was used, then nginx did not run.

    *) Bugfix: the "ip_hash" directive might incorrectly mark servers as
       down.

    *) Bugfix: nginx could not be built on amd64; the bug had appeared in
       0.6.8.


Changes with nginx 0.6.8                                         20 Aug 2007

    *) Change: now nginx tries to set the "worker_priority",
       "worker_rlimit_nofile", "worker_rlimit_core", and
       "worker_rlimit_sigpending" without super-user privileges.

    *) Change: now nginx escapes space and "%" in request to a mail proxy
       authentication server.

    *) Change: now nginx escapes "%" in $memcached_key variable.

    *) Bugfix: nginx used path relative to configuration prefix for
       non-absolute configuration file path specified in the "-c" key; the
       bug had appeared in 0.6.6.

    *) Bugfix: nginx did not work on FreeBSD/sparc64.


Changes with nginx 0.6.7                                         15 Aug 2007

    *) Change: now the paths specified in the "include",
       "auth_basic_user_file", "perl_modules", "ssl_certificate",
       "ssl_certificate_key", and "ssl_client_certificate" directives are
       relative to directory of nginx configuration file nginx.conf, but not
       to nginx prefix directory.

    *) Change: the --sysconfdir=PATH option in configure was canceled.

    *) Change: the special make target "upgrade1" was defined for online
       upgrade of 0.1.x versions.

    *) Feature: the "server_name" and "valid_referers" directives support
       regular expressions.

    *) Feature: the "server" directive in the "upstream" context supports
       the "backup" parameter.

    *) Feature: the ngx_http_perl_module supports the
       $r->discard_request_body.

    *) Feature: the "add_header Last-Modified ..." directive changes the
       "Last-Modified" response header line.

    *) Bugfix: if a response different than 200 was returned to a request
       with body and connection went to the keep-alive state after the
       request, then nginx returned 400 for the next request.

    *) Bugfix: a segmentation fault occurred in worker process if invalid
       address was set in the "auth_http" directive.

    *) Bugfix: now nginx uses default listen backlog value 511 on all
       platforms except FreeBSD.
       Thanks to Jiang Hong.

    *) Bugfix: a worker process may got caught in an endless loop, if a
       "server" inside "upstream" block was marked as "down"; the bug had
       appeared in 0.6.6.

    *) Bugfix: now Solaris sendfilev() is not used to transfer the client
       request body to FastCGI-server via the unix domain socket.


Changes with nginx 0.6.6                                         30 Jul 2007

    *) Feature: the --sysconfdir=PATH option in configure.

    *) Feature: named locations.

    *) Feature: the $args variable can be set with the "set" directive.

    *) Feature: the $is_args variable.

    *) Bugfix: fair big weight upstream balancer.

    *) Bugfix: if a client has closed connection to mail proxy then nginx
       might not close connection to backend.

    *) Bugfix: if the same host without specified port was used as backend
       for HTTP and HTTPS, then nginx used only one port - 80 or 443.

    *) Bugfix: fix building on Solaris/amd64 by Sun Studio 11 and early
       versions; the bug had appeared in 0.6.4.


Changes with nginx 0.6.5                                         23 Jul 2007

    *) Feature: $nginx_version variable.
       Thanks to Nick S. Grechukh.

    *) Feature: the mail proxy supports AUTHENTICATE in IMAP mode.
       Thanks to Maxim Dounin.

    *) Feature: the mail proxy supports STARTTLS in SMTP mode.
       Thanks to Maxim Dounin.

    *) Bugfix: now nginx escapes space in $memcached_key variable.

    *) Bugfix: nginx was incorrectly built by Sun Studio on Solaris/amd64.
       Thanks to Jiang Hong.

    *) Bugfix: of minor potential bugs.
       Thanks to Coverity's Scan.


Changes with nginx 0.6.4                                         17 Jul 2007

    *) Security: the "msie_refresh" directive allowed XSS.
       Thanks to Maxim Boguk.

    *) Change: the "proxy_store" and "fastcgi_store" directives were
       changed.

    *) Feature: the "proxy_store_access" and "fastcgi_store_access"
       directives.

    *) Bugfix: nginx did not work on Solaris/sparc64 if it was built by Sun
       Studio.
       Thanks to Andrei Nigmatulin.

    *) Workaround: for Sun Studio 12.
       Thanks to Jiang Hong.


Changes with nginx 0.6.3                                         12 Jul 2007

    *) Feature: the "proxy_store" and "fastcgi_store" directives.

    *) Bugfix: a segmentation fault might occur in worker process if the
       "auth_http_header" directive was used.
       Thanks to Maxim Dounin.

    *) Bugfix: a segmentation fault occurred in worker process if the
       CRAM-MD5 authentication method was used, but it was not enabled.

    *) Bugfix: a segmentation fault might occur in worker process when the
       HTTPS protocol was used in the "proxy_pass" directive.

    *) Bugfix: a segmentation fault might occur in worker process if the
       eventport method was used.

    *) Bugfix: the "proxy_ignore_client_abort" and
       "fastcgi_ignore_client_abort" directives did not work; the bug had
       appeared in 0.5.13.


Changes with nginx 0.6.2                                         09 Jul 2007

    *) Bugfix: if the FastCGI header was split in records, then nginx passed
       garbage in the header to a client.


Changes with nginx 0.6.1                                         17 Jun 2007

    *) Bugfix: in SSI parsing.

    *) Bugfix: if remote SSI subrequest was used, then posterior local file
       subrequest might transferred to client in wrong order.

    *) Bugfix: large SSI inclusions buffered in temporary files were
       truncated.

    *) Bugfix: the perl $$ variable value in ngx_http_perl_module was equal
       to the master process identification number.


Changes with nginx 0.6.0                                         14 Jun 2007

    *) Feature: the "server_name", "map", and "valid_referers" directives
       support the "www.example.*" wildcards.


Changes with nginx 0.5.25                                        11 Jun 2007

    *) Bugfix: nginx could not be built with the
       --without-http_rewrite_module parameter; the bug had appeared in
       0.5.24.


Changes with nginx 0.5.24                                        06 Jun 2007

    *) Security: the "ssl_verify_client" directive did not work if request
       was made using HTTP/0.9.

    *) Bugfix: a part of response body might be passed uncompressed if gzip
       was used; the bug had appeared in 0.5.23.


Changes with nginx 0.5.23                                        04 Jun 2007

    *) Feature: the ngx_http_ssl_module supports Server Name Indication TLS
       extension.

    *) Feature: the "fastcgi_catch_stderr" directive.
       Thanks to Nick S. Grechukh, OWOX project.

    *) Bugfix: a segmentation fault occurred in master process if two
       virtual servers should bind() to the overlapping ports.

    *) Bugfix: if nginx was built with ngx_http_perl_module and perl
       supported threads, then during second reconfiguration the error
       messages "panic: MUTEX_LOCK" and "perl_parse() failed" were issued.

    *) Bugfix: in the HTTPS protocol in the "proxy_pass" directive.


Changes with nginx 0.5.22                                        29 May 2007

    *) Bugfix: a big request body might not be passed to backend; the bug
       had appeared in 0.5.21.


Changes with nginx 0.5.21                                        28 May 2007

    *) Bugfix: if server has more than about ten locations, then regex
       locations might be chosen not in that order as they were specified.

    *) Bugfix: a worker process may got caught in an endless loop on 64-bit
       platform, if the 33-rd or next in succession backend has failed.
       Thanks to Anton Povarov.

    *) Bugfix: a bus error might occur on Solaris/sparc64 if the PCRE
       library was used.
       Thanks to Andrei Nigmatulin.

    *) Bugfix: in the HTTPS protocol in the "proxy_pass" directive.


Changes with nginx 0.5.20                                        07 May 2007

    *) Feature: the "sendfile_max_chunk" directive.

    *) Feature: the "$http_...", "$sent_http_...", and "$upstream_http_..."
       variables may be changed using the "set" directive.

    *) Bugfix: a segmentation fault might occur in worker process if the SSI
       command 'if expr="$var = /"' was used.

    *) Bugfix: trailing boundary of multipart range response was transferred
       incorrectly.
       Thanks to Evan Miller.

    *) Bugfix: nginx did not work on Solaris/sparc64 if it was built by Sun
       Studio.
       Thanks to Andrei Nigmatulin.

    *) Bugfix: the ngx_http_perl_module could not be built by Solaris make.
       Thanks to Andrei Nigmatulin.


Changes with nginx 0.5.19                                        24 Apr 2007

    *) Change: now the $request_time variable has millisecond precision.

    *) Change: the method $r->rflush of ngx_http_perl_module was renamed to
       the $r->flush.

    *) Feature: the $upstream_addr variable.

    *) Feature: the "proxy_headers_hash_max_size" and
       "proxy_headers_hash_bucket_size" directives.
       Thanks to Volodymyr Kostyrko.

    *) Bugfix: the files more than 2G could not be transferred using
       sendfile and limit_rate on 64-bit platforms.

    *) Bugfix: the files more than 2G could not be transferred using
       sendfile on 64-bit Linux.


Changes with nginx 0.5.18                                        19 Apr 2007

    *) Feature: the ngx_http_sub_filter_module.

    *) Feature: the "$upstream_http_..." variables.

    *) Feature: now the $upstream_status and $upstream_response_time
       variables keep data about all upstreams before X-Accel-Redirect.

    *) Bugfix: a segmentation fault occurred in master process after first
       reconfiguration and receiving any signal if nginx was built with
       ngx_http_perl_module and perl did not support multiplicity; the bug
       had appeared in 0.5.9.

    *) Bugfix: if perl did not support multiplicity, then after
       reconfiguration perl code did not work; the bug had appeared in
       0.3.38.


Changes with nginx 0.5.17                                        02 Apr 2007

    *) Change: now nginx always returns the 405 status for the TRACE method.

    *) Feature: now nginx supports the "include" directive inside the
       "types" block.

    *) Bugfix: the $document_root variable usage in the "root" and "alias"
       directives is disabled: this caused recursive stack overflow.

    *) Bugfix: in the HTTPS protocol in the "proxy_pass" directive.

    *) Bugfix: in some cases non-cacheable variables (such as $uri variable)
       returned old cached value.


Changes with nginx 0.5.16                                        26 Mar 2007

    *) Bugfix: the C-class network was not used as hash key in the "ip_hash"
       directive.
       Thanks to Pavel Yarkovoy.

    *) Bugfix: a segmentation fault might occur in worker process if a
       charset was set in the "Content-Type" header line and the line has
       trailing ";"; the bug had appeared in 0.3.50.

    *) Bugfix: the "[alert] zero size buf" error when FastCGI server was
       used and a request body written in a temporary file was multiple of
       32K.

    *) Bugfix: nginx could not be built on Solaris without the --with-debug
       option; the bug had appeared in 0.5.15.


Changes with nginx 0.5.15                                        19 Mar 2007

    *) Feature: the mail proxy supports authenticated SMTP proxying and the
       "smtp_auth", "smtp_capabilities", and "xclient" directives.
       Thanks to Anton Yuzhaninov and Maxim Dounin.

    *) Feature: now the keep-alive connections are closed just after
       receiving the reconfiguration signal.

    *) Change: the "imap" and "auth" directives were renamed to the "mail"
       and "pop3_auth" directives.

    *) Bugfix: a segmentation fault occurred in worker process if the
       CRAM-MD5 authentication method was used and the APOP method was
       disabled.

    *) Bugfix: if the "starttls only" directive was used in POP3 protocol,
       then nginx allowed authentication without switching to the SSL mode.

    *) Bugfix: worker processes did not exit after reconfiguration and did
       not rotate logs if the eventport method was used.

    *) Bugfix: a worker process may got caught in an endless loop, if the
       "ip_hash" directive was used.

    *) Bugfix: now nginx does not log some alerts if eventport or /dev/poll
       methods are used.


Changes with nginx 0.5.14                                        23 Feb 2007

    *) Bugfix: nginx ignored superfluous closing "}" in the end of
       configuration file.


Changes with nginx 0.5.13                                        19 Feb 2007

    *) Feature: the COPY and MOVE methods.

    *) Bugfix: the ngx_http_realip_module set garbage for requests passed
       via keep-alive connection.

    *) Bugfix: nginx did not work on big-endian 64-bit Linux.
       Thanks to Andrei Nigmatulin.

    *) Bugfix: now when IMAP/POP3 proxy receives too long command it closes
       the connection right away, but not after timeout.

    *) Bugfix: if the "epoll" method was used and a client closed a
       connection prematurely, then nginx closed the connection after a send
       timeout only.

    *) Bugfix: nginx could not be built on platforms different from i386,
       amd64, sparc, and ppc; the bug had appeared in 0.5.8.


Changes with nginx 0.5.12                                        12 Feb 2007

    *) Bugfix: nginx could not be built on platforms different from i386,
       amd64, sparc, and ppc; the bug had appeared in 0.5.8.

    *) Bugfix: a segmentation fault might occur in worker process if the
       temporary files were used while working with FastCGI server; the bug
       had appeared in 0.5.8.

    *) Bugfix: a segmentation fault might occur in worker process if the
       $fastcgi_script_name variable was logged.

    *) Bugfix: ngx_http_perl_module could not be built on Solaris.


Changes with nginx 0.5.11                                        05 Feb 2007

    *) Feature: now configure detects system PCRE library in MacPorts.
       Thanks to Chris McGrath.

    *) Bugfix: the response was incorrect if several ranges were requested;
       the bug had appeared in 0.5.6.

    *) Bugfix: the "create_full_put_path" directive could not create the
       intermediate directories if no "dav_access" directive was set.
       Thanks to Evan Miller.

    *) Bugfix: the "0" response code might be logged in the access_log
       instead of the "400" and "408" error codes.

    *) Bugfix: a segmentation fault might occur in worker process if nginx
       was built with -O2 optimization.


Changes with nginx 0.5.10                                        26 Jan 2007

    *) Bugfix: while online executable file upgrade the new master process
       did not inherit the listening sockets; the bug had appeared in 0.5.9.

    *) Bugfix: a segmentation fault might occur in worker process if nginx
       was built with -O2 optimization; the bug had appeared in 0.5.1.


Changes with nginx 0.5.9                                         25 Jan 2007

    *) Change: now the ngx_http_memcached_module uses the $memcached_key
       variable value as a key.

    *) Feature: the $memcached_key variable.

    *) Feature: the "clean" parameter in the "client_body_in_file_only"
       directive.

    *) Feature: the "env" directive.

    *) Feature: the "sendfile" directive is available inside the "if" block.

    *) Feature: now on failure of the writing to access nginx logs a message
       to error_log, but not more often than once a minute.

    *) Bugfix: the "access_log off" directive did not always turn off the
       logging.


Changes with nginx 0.5.8                                         19 Jan 2007

    *) Bugfix: a segmentation fault might occur if
       "client_body_in_file_only on" was used and a request body was small.

    *) Bugfix: a segmentation fault occurred if
       "client_body_in_file_only on" and "proxy_pass_request_body off" or
       "fastcgi_pass_request_body off" directives were used, and nginx
       switched to a next upstream.

    *) Bugfix: if the "proxy_buffering off" directive was used and a client
       connection was non-active, then the connection was closed after send
       timeout; the bug had appeared in 0.4.7.

    *) Bugfix: if the "epoll" method was used and a client closed a
       connection prematurely, then nginx closed the connection after a send
       timeout only.

    *) Bugfix: the "[alert] zero size buf" error when FastCGI server was
       used.

    *) Bugfixes in the "limit_zone" directive.


Changes with nginx 0.5.7                                         15 Jan 2007

    *) Feature: the ssl_session_cache storage optimization.

    *) Bugfixes in the "ssl_session_cache" and "limit_zone" directives.

    *) Bugfix: the segmentation fault was occurred on start or while
       reconfiguration if the "ssl_session_cache" or "limit_zone" directives
       were used on 64-bit platforms.

    *) Bugfix: a segmentation fault occurred if the "add_before_body" or
       "add_after_body" directives were used and there was no "Content-Type"
       header line in response.

    *) Bugfix: the OpenSSL library was always built with the threads
       support.
       Thanks to Den Ivanov.

    *) Bugfix: the PCRE-6.5+ library and the icc compiler compatibility.


Changes with nginx 0.5.6                                         09 Jan 2007

    *) Change: now the ngx_http_index_module ignores all methods except the
       GET, HEAD, and POST methods.

    *) Feature: the ngx_http_limit_zone_module.

    *) Feature: the $binary_remote_addr variable.

    *) Feature: the "ssl_session_cache" directives of the
       ngx_http_ssl_module and ngx_imap_ssl_module.

    *) Feature: the DELETE method supports recursive removal.

    *) Bugfix: the byte-ranges were transferred incorrectly if the
       $r->sendfile() was used.


Changes with nginx 0.5.5                                         24 Dec 2006

    *) Change: the -v switch does not show compiler information any more.

    *) Feature: the -V switch.

    *) Feature: the "worker_rlimit_core" directive supports size in K, M,
       and G.

    *) Bugfix: the nginx.pm module now could be installed by an unprivileged
       user.

    *) Bugfix: a segmentation fault might occur if the $r->request_body or
       $r->request_body_file methods were used.

    *) Bugfix: the ppc platform specific bugs.


Changes with nginx 0.5.4                                         15 Dec 2006

    *) Feature: the "perl" directive may be used inside the "limit_except"
       block.

    *) Bugfix: the ngx_http_dav_module required the "Date" request header
       line for the DELETE method.

    *) Bugfix: if one only parameter was used in the "dav_access" directive,
       then nginx might report about configuration error.

    *) Bugfix: a segmentation fault might occur if the $host variable was
       used; the bug had appeared in 0.4.14.


Changes with nginx 0.5.3                                         13 Dec 2006

    *) Feature: the ngx_http_perl_module supports the $r->status,
       $r->log_error, and $r->sleep methods.

    *) Feature: the $r->variable method supports variables that do not exist
       in nginx configuration.

    *) Bugfix: the $r->has_request_body method did not work.


Changes with nginx 0.5.2                                         11 Dec 2006

    *) Bugfix: if the "proxy_pass" directive used the name of the "upstream"
       block, then nginx tried to resolve the name; the bug had appeared in
       0.5.1.


Changes with nginx 0.5.1                                         11 Dec 2006

    *) Bugfix: the "post_action" directive might not run after a
       unsuccessful completion of a request.

    *) Workaround: for Eudora for Mac; the bug had appeared in 0.4.11.
       Thanks to Bron Gondwana.

    *) Bugfix: if the "upstream" name was used in the "fastcgi_pass", then
       the message "no port in upstream" was issued; the bug had appeared in
       0.5.0.

    *) Bugfix: if the "proxy_pass" and "fastcgi_pass" directives used the
       same servers but different ports, then these directives uses the
       first described port; the bug had appeared in 0.5.0.

    *) Bugfix: if the "proxy_pass" and "fastcgi_pass" directives used the
       unix domain sockets, then these directives used first described
       socket; the bug had appeared in 0.5.0.

    *) Bugfix: ngx_http_auth_basic_module ignored the user if it was in the
       last line in the password file and there was no the carriage return,
       the line feed, or the ":" symbol after the password.

    *) Bugfix: the $upstream_response_time variable might be equal to
       "0.000", although response time was more than 1 millisecond.


Changes with nginx 0.5.0                                         04 Dec 2006

    *) Change: the parameters in the "%name" form in the "log_format"
       directive are not supported anymore.

    *) Change: the "proxy_upstream_max_fails",
       "proxy_upstream_fail_timeout", "fastcgi_upstream_max_fails",
       "fastcgi_upstream_fail_timeout", "memcached_upstream_max_fails", and
       "memcached_upstream_fail_timeout" directives are not supported
       anymore.

    *) Feature: the "server" directive in the "upstream" context supports
       the "max_fails", "fail_timeout", and "down" parameters.

    *) Feature: the "ip_hash" directive inside the "upstream" block.

    *) Feature: the WAIT status in the "Auth-Status" header line of the
       IMAP/POP3 proxy authentication server response.

    *) Bugfix: nginx could not be built on 64-bit platforms; the bug had
       appeared in 0.4.14.


Changes with nginx 0.4.14                                        27 Nov 2006

    *) Feature: the "proxy_pass_error_message" directive in IMAP/POP3 proxy.

    *) Feature: now configure detects system PCRE library on FreeBSD, Linux,
       and NetBSD.

    *) Bugfix: ngx_http_perl_module did not work with perl built with the
       threads support; the bug had appeared in 0.3.38.

    *) Bugfix: ngx_http_perl_module did not work if perl was called
       recursively.

    *) Bugfix: nginx ignored a host name in a request line.

    *) Bugfix: a worker process may got caught in an endless loop, if a
       FastCGI server sent too many data to the stderr.

    *) Bugfix: the $upstream_response_time variable may be negative if the
       system time was changed backward.

    *) Bugfix: the "Auth-Login-Attempt" parameter was not sent to IMAP/POP3
       proxy authentication server when POP3 was used.

    *) Bugfix: a segmentation fault might occur if connect to IMAP/POP3
       proxy authentication server failed.


Changes with nginx 0.4.13                                        15 Nov 2006

    *) Feature: the "proxy_pass" directive may be used inside the
       "limit_except" block.

    *) Feature: the "limit_except" directive supports all WebDAV methods.

    *) Bugfix: if the "add_before_body" directive was used without the
       "add_after_body" directive, then a response did not transferred
       complete.

    *) Bugfix: a large request body did not receive if the epoll method and
       the deferred accept() were used.

    *) Bugfix: a charset could not be set for ngx_http_autoindex_module
       responses; the bug had appeared in 0.3.50.

    *) Bugfix: the "[alert] zero size buf" error when FastCGI server was
       used;

    *) Bugfix: the --group= configuration parameter was ignored.
       Thanks to Thomas Moschny.

    *) Bugfix: the 50th subrequest in SSI response did not work; the bug had
       appeared in 0.3.50.


Changes with nginx 0.4.12                                        31 Oct 2006

    *) Feature: the ngx_http_perl_module supports the $r->variable method.

    *) Bugfix: if a big static file was included using SSI in a response,
       then the response may be transferred incomplete.

    *) Bugfix: nginx did not omit the "#fragment" part in URI.


Changes with nginx 0.4.11                                        25 Oct 2006

    *) Feature: the POP3 proxy supports the AUTH LOGIN PLAIN and CRAM-MD5.

    *) Feature: the ngx_http_perl_module supports the $r->allow_ranges
       method.

    *) Bugfix: if the APOP was enabled in the POP3 proxy, then the USER/PASS
       commands might not work; the bug had appeared in 0.4.10.


Changes with nginx 0.4.10                                        23 Oct 2006

    *) Feature: the POP3 proxy supports the APOP command.

    *) Bugfix: if the select, poll or /dev/poll methods were used, then
       while waiting authentication server response the IMAP/POP3 proxy
       hogged CPU.

    *) Bugfix: a segmentation fault might occur if the $server_addr variable
       was used in the "map" directive.

    *) Bugfix: the ngx_http_flv_module did not support the byte ranges for
       full responses; the bug had appeared in 0.4.7.

    *) Bugfix: nginx could not be built on Debian amd64; the bug had
       appeared in 0.4.9.


Changes with nginx 0.4.9                                         13 Oct 2006

    *) Feature: the "set" parameter in the "include" SSI command.

    *) Feature: the ngx_http_perl_module now tests the nginx.pm module
       version.


Changes with nginx 0.4.8                                         11 Oct 2006

    *) Bugfix: if an "include" SSI command were before another "include" SSI
       command with a "wait" parameter, then the "wait" parameter might not
       work.

    *) Bugfix: the ngx_http_flv_module added the FLV header to the full
       responses.
       Thanks to Alexey Kovyrin.


Changes with nginx 0.4.7                                         10 Oct 2006

    *) Feature: the ngx_http_flv_module.

    *) Feature: the $request_body_file variable.

    *) Feature: the "charset" and "source_charset" directives support the
       variables.

    *) Bugfix: if an "include" SSI command were before another "include" SSI
       command with a "wait" parameter, then the "wait" parameter might not
       work.

    *) Bugfix: if the "proxy_buffering off" directive was used or while
       working with memcached the connections might not be closed on
       timeout.

    *) Bugfix: nginx did not run on 64-bit platforms except amd64, sparc64,
       and ppc64.


Changes with nginx 0.4.6                                         06 Oct 2006

    *) Bugfix: nginx did not run on 64-bit platforms except amd64, sparc64,
       and ppc64.

    *) Bugfix: nginx sent the chunked response for HTTP/1.1 request,
       if its length was set by text string in the
       $r->headers_out("Content-Length", ...) method.

    *) Bugfix: after redirecting error by an "error_page" directive any
       ngx_http_rewrite_module directive returned this error code; the bug
       had appeared in 0.4.4.


Changes with nginx 0.4.5                                         02 Oct 2006

    *) Bugfix: nginx could not be built on Linux and Solaris; the bug had
       appeared in 0.4.4.


Changes with nginx 0.4.4                                         02 Oct 2006

    *) Feature: the $scheme variable.

    *) Feature: the "expires" directive supports the "max" parameter.

    *) Feature: the "include" directive supports the "*" mask.
       Thanks to Jonathan Dance.

    *) Bugfix: the "return" directive always overrode the "error_page"
       response code redirected by the "error_page" directive.

    *) Bugfix: a segmentation fault occurred if zero-length body was in PUT
       method.

    *) Bugfix: the redirect was changed incorrectly if the variables were
       used in the "proxy_redirect" directive.


Changes with nginx 0.4.3                                         26 Sep 2006

    *) Change: now the 499 error could not be redirected using an
       "error_page" directive.

    *) Feature: the Solaris 10 event ports support.

    *) Feature: the ngx_http_browser_module.

    *) Bugfix: a segmentation fault may occur while redirecting the 400
       error to the proxied server using a "proxy_pass" directive.

    *) Bugfix: a segmentation fault occurred if an unix domain socket was
       used in a "proxy_pass" directive; the bug had appeared in 0.3.47.

    *) Bugfix: SSI did work with memcached and nonbuffered responses.

    *) Workaround: of the Sun Studio PAUSE hardware capability bug.


Changes with nginx 0.4.2                                         14 Sep 2006

    *) Bugfix: the O_NOATIME flag support on Linux was canceled; the bug had
       appeared in 0.4.1.


Changes with nginx 0.4.1                                         14 Sep 2006

    *) Bugfix: the DragonFlyBSD compatibility.
       Thanks to Pavel Nazarov.

    *) Workaround: of bug in 64-bit Linux sendfile(), when file is more than
       2G.

    *) Feature: now on Linux nginx uses O_NOATIME flag for static requests.
       Thanks to Yusuf Goolamabbas.


Changes with nginx 0.4.0                                         30 Aug 2006

    *) Change in internal API: the HTTP modules initialization was moved
       from the init module phase to the HTTP postconfiguration phase.

    *) Change: now the request body is not read beforehand for the
       ngx_http_perl_module: it's required to start the reading using the
       $r->has_request_body method.

    *) Feature: the ngx_http_perl_module supports the DECLINED return code.

    *) Feature: the ngx_http_dav_module supports the incoming "Date" header
       line for the PUT method.

    *) Feature: the "ssi" directive is available inside the "if" block.

    *) Bugfix: a segmentation fault occurred if there was an "index"
       directive with variables and the first index name was without
       variables; the bug had appeared in 0.1.29.


Changes with nginx 0.3.61                                        28 Aug 2006

    *) Change: now the "tcp_nodelay" directive is turned on by default.

    *) Feature: the "msie_refresh" directive.

    *) Feature: the "recursive_error_pages" directive.

    *) Bugfix: the "rewrite" directive returned incorrect redirect, if the
       redirect had the captured escaped symbols from original URI.


Changes with nginx 0.3.60                                        18 Aug 2006

    *) Bugfix: a worker process may got caught in an endless loop while an
       error redirection; the bug had appeared in 0.3.59.


Changes with nginx 0.3.59                                        16 Aug 2006

    *) Feature: now is possible to do several redirection using the
       "error_page" directive.

    *) Bugfix: the "dav_access" directive did not support three parameters.

    *) Bugfix: the "error_page" directive did not changes the "Content-Type"
       header line after the "X-Accel-Redirect" was used; the bug had
       appeared in 0.3.58.


Changes with nginx 0.3.58                                        14 Aug 2006

    *) Feature: the "error_page" directive supports the variables.

    *) Change: now the procfs interface instead of sysctl is used on Linux.

    *) Change: now the "Content-Type" header line is inherited from first
       response when the "X-Accel-Redirect" was used.

    *) Bugfix: the "error_page" directive did not redirect the 413 error.

    *) Bugfix: the trailing "?" did not remove old arguments if no new
       arguments were added to a rewritten URI.

    *) Bugfix: nginx could not run on 64-bit FreeBSD 7.0-CURRENT.


Changes with nginx 0.3.57                                        09 Aug 2006

    *) Feature: the $ssl_client_serial variable.

    *) Bugfix: in the "!-e" operator of the "if" directive.
       Thanks to Andrian Budanstov.

    *) Bugfix: while a client certificate verification nginx did not send to
       a client the required certificates information.

    *) Bugfix: the $document_root variable did not support the variables in
       the "root" directive.


Changes with nginx 0.3.56                                        04 Aug 2006

    *) Feature: the "dav_access" directive.

    *) Feature: the "if" directive supports the "-d", "!-d", "-e", "!-e",
       "-x", and "!-x" operators.

    *) Bugfix: a segmentation fault occurred if a request returned a
       redirect and some sent to client header lines were logged in the
       access log.


Changes with nginx 0.3.55                                        28 Jul 2006

    *) Feature: the "stub" parameter in the "include" SSI command.

    *) Feature: the "block" SSI command.

    *) Feature: the unicode2nginx script was added to contrib.

    *) Bugfix: if a "root" was specified by variable only, then the root was
       relative to a server prefix.

    *) Bugfix: if the request contained "//" or "/./" and escaped symbols
       after them, then the proxied request was sent unescaped.

    *) Bugfix: the $r->header_in("Cookie") of the ngx_http_perl_module now
       returns all "Cookie" header lines.

    *) Bugfix: a segmentation fault occurred if
       "client_body_in_file_only on" was used and nginx switched to a next
       upstream.

    *) Bugfix: on some condition while reconfiguration character codes
       inside the "charset_map" may be treated invalid; the bug had appeared
       in 0.3.50.


Changes with nginx 0.3.54                                        11 Jul 2006

    *) Feature: nginx now logs the subrequest information to the error log.

    *) Feature: the "proxy_next_upstream", "fastcgi_next_upstream", and
       "memcached_next_upstream" directives support the "off" parameter.

    *) Feature: the "debug_connection" directive supports the CIDR address
       form.

    *) Bugfix: if a response of proxied server or FastCGI server was
       converted from UTF-8 or back, then it may be transferred incomplete.

    *) Bugfix: the $upstream_response_time variable had the time of the
       first request to a backend only.

    *) Bugfix: nginx could not be built on amd64 platform; the bug had
       appeared in 0.3.53.


Changes with nginx 0.3.53                                        07 Jul 2006

    *) Change: the "add_header" directive adds the string to 204, 301, and
       302 responses.

    *) Feature: the "server" directive in the "upstream" context supports
       the "weight" parameter.

    *) Feature: the "server_name" directive supports the "*" wildcard.

    *) Feature: nginx supports the request body size more than 2G.

    *) Bugfix: if a client was successfully authorized using "satisfy_any
       on", then anyway the message "access forbidden by rule" was written
       in the log.

    *) Bugfix: the "PUT" method may erroneously not create a file and return
       the 409 code.

    *) Bugfix: if the IMAP/POP3 backend returned an error, then nginx
       continued proxying anyway.


Changes with nginx 0.3.52                                        03 Jul 2006

    *) Change: the ngx_http_index_module behavior for the "POST /" requests
       is reverted to the 0.3.40 version state: the module now does not
       return the 405 error.

    *) Bugfix: the worker process may got caught in an endless loop if the
       limit rate was used; the bug had appeared in 0.3.37.

    *) Bugfix: ngx_http_charset_module logged "unknown charset" alert, even
       if the recoding was not needed; the bug had appeared in 0.3.50.

    *) Bugfix: if a code response of the PUT request was 409, then a
       temporary file was not removed.


Changes with nginx 0.3.51                                        30 Jun 2006

    *) Bugfix: the "<" symbols might disappeared some conditions in the SSI;
       the bug had appeared in 0.3.50.


Changes with nginx 0.3.50                                        28 Jun 2006

    *) Change: the "proxy_redirect_errors" and "fastcgi_redirect_errors"
       directives was renamed to the "proxy_intercept_errors" and
       "fastcgi_intercept_errors" directives.

    *) Feature: the ngx_http_charset_module supports the recoding from the
       single byte encodings to the UTF-8 encoding and back.

    *) Feature: the "X-Accel-Charset" response header line is supported in
       proxy and FastCGI mode.

    *) Bugfix: the "\" escape symbol in the "\"" and "\'" pairs in the SSI
       command was removed only if the command also has the "$" symbol.

    *) Bugfix: the "<!--" string might be added on some conditions in the
       SSI after inclusion.

    *) Bugfix: if the "Content-Length: 0" header line was in response, then
       in nonbuffered proxying mode the client connection was not closed.


Changes with nginx 0.3.49                                        31 May 2006

    *) Bugfix: in the "set" directive.

    *) Bugfix: if two or more FastCGI subrequests was in SSI, then first
       subrequest output was included instead of second and following
       subrequests.


Changes with nginx 0.3.48                                        29 May 2006

    *) Change: now the ngx_http_charset_module works for subrequests, if the
       response has no "Content-Type" header line.

    *) Bugfix: if the "proxy_pass" directive has no URI part, then the
       "proxy_redirect default" directive add the unnecessary slash in start
       of the rewritten redirect.

    *) Bugfix: the internal redirect always transform client's HTTP method
       to GET, now the transformation is made for the "X-Accel-Redirect"
       redirects only and if the method is not HEAD; the bug had appeared in
       0.3.42.

    *) Bugfix: the ngx_http_perl_module could not be built, if the perl was
       built with the threads support; the bug had appeared in 0.3.46.


Changes with nginx 0.3.47                                        23 May 2006

    *) Feature: the "upstream" directive.

    *) Change: now the "\" escape symbol in the "\"" and "\'" pairs in the
       SSI command is always removed.


Changes with nginx 0.3.46                                        11 May 2006

    *) Feature: the "proxy_hide_header", "proxy_pass_header",
       "fastcgi_hide_header", and "fastcgi_pass_header" directives.

    *) Change: the "proxy_pass_x_powered_by", "fastcgi_x_powered_by", and
       "proxy_pass_server" directives were canceled.

    *) Feature: the "X-Accel-Buffering" response header line is supported in
       proxy mode.

    *) Bugfix: the reconfiguration bug and memory leaks in the
       ngx_http_perl_module.


Changes with nginx 0.3.45                                        06 May 2006

    *) Feature: the "ssl_verify_client", "ssl_verify_depth", and
       "ssl_client_certificate" directives.

    *) Change: the $request_method variable now returns the main request
       method.

    *) Change: the &deg; symbol codes were changed in koi-win conversion
       table.

    *) Feature: the euro and N symbols were added to koi-win conversion
       table.

    *) Bugfix: if nginx distributed the requests among several backends and
       some backend failed, then requests intended for this backend was
       directed to one live backend only instead of being distributed among
       the rest.


Changes with nginx 0.3.44                                        04 May 2006

    *) Feature: the "wait" parameter in the "include" SSI command.

    *) Feature: the Ukrainian and Byelorussian characters were added to
       koi-win conversion table.

    *) Bugfix: in the SSI.


Changes with nginx 0.3.43                                        26 Apr 2006

    *) Bugfix: in the SSI.


Changes with nginx 0.3.42                                        26 Apr 2006

    *) Feature: the "bind" option of the "listen" directive in IMAP/POP3
       proxy.

    *) Bugfix: if the same capture in the "rewrite" directive was used more
       then once.

    *) Bugfix: the $sent_http_content_type, $sent_http_content_length,
       $sent_http_last_modified, $sent_http_connection,
       $sent_http_keep_alive, and $sent_http_transfer_encoding variables
       were not written to access log.

    *) Bugfix: the $sent_http_cache_control returned value of the single
       "Cache-Control" response header line.


Changes with nginx 0.3.41                                        21 Apr 2006

    *) Feature: the -v switch.

    *) Bugfix: the segmentation fault may occurred if the SSI page has
       remote subrequests.

    *) Bugfix: in FastCGI handling.

    *) Bugfix: if the perl modules path was not set using
       --with-perl_modules_path=PATH or the "perl_modules", then the
       segmentation fault was occurred.


Changes with nginx 0.3.40                                        19 Apr 2006

    *) Feature: the ngx_http_dav_module supports the MKCOL method.

    *) Feature: the "create_full_put_path" directive.

    *) Feature: the "$limit_rate" variable.


Changes with nginx 0.3.39                                        17 Apr 2006

    *) Feature: the "uninitialized_variable_warn" directive; the logging
       level of the "uninitialized variable" message was lowered from
       "alert" to "warn".

    *) Feature: the "override_charset" directive.

    *) Change: now if the unknown variable is used in the "echo" and "if
       expr='$name'" SSI-commands, then the "unknown variable" message is
       not logged.

    *) Bugfix: the active connection counter increased on the exceeding of
       the connection limit specified by the "worker_connections" directive;
       the bug had appeared in 0.2.0.

    *) Bugfix: the limit rate might not work on some condition; the bug had
       appeared in 0.3.38.


Changes with nginx 0.3.38                                        14 Apr 2006

    *) Feature: the ngx_http_dav_module.

    *) Change: the ngx_http_perl_module optimizations.
       Thanks to Sergey Skvortsov.

    *) Feature: the ngx_http_perl_module supports the $r->request_body_file
       method.

    *) Feature: the "client_body_in_file_only" directive.

    *) Workaround: now on disk overflow nginx tries to write access logs
       once a second only.
       Thanks to Anton Yuzhaninov and Maxim Dounin.

    *) Bugfix: now the "limit_rate" directive more precisely limits rate if
       rate is more than 100 Kbyte/s.
       Thanks to ForJest.

    *) Bugfix: now the IMAP/POP3 proxy escapes the "\r" and "\n" symbols in
       login and password to pass authorization server.
       Thanks to Maxim Dounin.


Changes with nginx 0.3.37                                        07 Apr 2006

    *) Feature: the "limit_except" directive.

    *) Feature: the "if" directive supports the "!~", "!~*", "-f", and "!-f"
       operators.

    *) Feature: the ngx_http_perl_module supports the $r->request_body
       method.

    *) Bugfix: in the ngx_http_addition_filter_module.


Changes with nginx 0.3.36                                        05 Apr 2006

    *) Feature: the ngx_http_addition_filter_module.

    *) Feature: the "proxy_pass" and "fastcgi_pass" directives may be used
       inside the "if" block.

    *) Feature: the "proxy_ignore_client_abort" and
       "fastcgi_ignore_client_abort" directives.

    *) Feature: the "$request_completion" variable.

    *) Feature: the ngx_http_perl_module supports the $r->request_method and
       $r->remote_addr.

    *) Feature: the ngx_http_ssi_module supports the "elif" command.

    *) Bugfix: the "\/" string in the expression of the "if" command of the
       ngx_http_ssi_module was treated incorrectly.

    *) Bugfix: in the regular expressions in the "if" command of the
       ngx_http_ssi_module.

    *) Bugfix: if the relative path was specified in the
       "client_body_temp_path", "proxy_temp_path", "fastcgi_temp_path", and
       "perl_modules" directives, then the directory was used relatively to
       a current path but not to a server prefix.


Changes with nginx 0.3.35                                        22 Mar 2006

    *) Bugfix: the accept-filter and the TCP_DEFER_ACCEPT option were set
       for first "listen" directive only; the bug had appeared in 0.3.31.

    *) Bugfix: in the "proxy_pass" directive without the URI part in a
       subrequest.


Changes with nginx 0.3.34                                        21 Mar 2006

    *) Feature: the "add_header" directive supports the variables.


Changes with nginx 0.3.33                                        15 Mar 2006

    *) Feature: the "http_503" parameter of the "proxy_next_upstream" or
       "fastcgi_next_upstream" directives.

    *) Bugfix: ngx_http_perl_module did not work with inlined in the
       configuration code, if it was not started with the "sub" word.

    *) Bugfix: in the "post_action" directive.


Changes with nginx 0.3.32                                        11 Mar 2006

    *) Bugfix: the debug logging on startup and reconfiguration time was
       removed; the bug had appeared in 0.3.31.


Changes with nginx 0.3.31                                        10 Mar 2006

    *) Change: now nginx passes the malformed proxied backend responses.

    *) Feature: the "listen" directives support the address in the "*:port"
       form.

    *) Feature: the EVFILER_TIMER support in MacOSX 10.4.

    *) Workaround: for MacOSX 64-bit kernel kqueue millisecond timeout bug.
       Thanks to Andrei Nigmatulin.

    *) Bugfix: if there were several "listen" directives listening one
       various addresses inside one server, then server names like
       "*.domain.tld" worked for first address only; the bug had appeared in
       0.3.18.

    *) Bugfix: if the HTTPS protocol was used in the "proxy_pass" directive
       and the request body was in temporary file then the request was not
       transferred.

    *) Bugfix: perl 5.8.8 compatibility.


Changes with nginx 0.3.30                                        22 Feb 2006

    *) Change: the ECONNABORTED error log level was changed to "error" from
       "crit".

    *) Bugfix: the ngx_http_perl_module could not be build without the
       ngx_http_ssi_filter_module.

    *) Bugfix: nginx could not be built on i386 platform, if the PIC was
       used; the bug had appeared in 0.3.27.


Changes with nginx 0.3.29                                        20 Feb 2006

    *) Feature: now nginx uses less memory, if PHP in FastCGI mode sends
       many warnings before the response.

    *) Bugfix: the "Transfer-Encoding: chunked" header line was issued in
       the 204 responses for the HTTP/1.1 requests.

    *) Bugfix: nginx returned the 502 response, if the complete response
       header lines were transferred in a separate FastCGI records.

    *) Bugfix: if the proxied URI was specified in the "post_action"
       directive, then it ran only after a successful completion of a
       request.


Changes with nginx 0.3.28                                        16 Feb 2006

    *) Feature: the "restrict_host_names" directive was canceled.

    *) Feature: the --with-cpu-opt=ppc64 configuration parameter.

    *) Bugfix: on some condition the proxied connection with a client was
       terminated prematurely.
       Thanks to Vladimir Shutoff.

    *) Bugfix: the "X-Accel-Limit-Rate" header line was not taken into
       account if the request was redirected using the "X-Accel-Redirect"
       header line.

    *) Bugfix: the "post_action" directive ran only after a successful
       completion of a request.

    *) Bugfix: the proxied response body generated by the "post_action"
       directive was transferred to a client.


Changes with nginx 0.3.27                                        08 Feb 2006

    *) Change: the "variables_hash_max_size" and
       "variables_hash_bucket_size" directives.

    *) Feature: the $body_bytes_sent variable can be used not only in the
       "log_format" directive.

    *) Feature: the $ssl_protocol and $ssl_cipher variables.

    *) Feature: the cache line size detection for widespread CPUs at start
       time.

    *) Feature: now the "accept_mutex" directive is supported using fcntl(2)
       on platforms different from i386, amd64, sparc64, and ppc.

    *) Feature: the "lock_file" directive and the --with-lock-path=PATH
       autoconfiguration directive.

    *) Bugfix: if the HTTPS protocol was used in the "proxy_pass" directive
       then the requests with the body was not transferred.


Changes with nginx 0.3.26                                        03 Feb 2006

    *) Change: the "optimize_host_names" directive was renamed to the
       "optimize_server_names".

    *) Bugfix: if in the "proxy_pass" directive was no the URI part, then
       the main request URI was transferred to a backend while proxying the
       SSI subrequest.


Changes with nginx 0.3.25                                        01 Feb 2006

    *) Bugfix: the segmentation fault was occurred on start or while
       reconfiguration if there was invalid configuration; the bug had
       appeared in 0.3.24.


Changes with nginx 0.3.24                                        01 Feb 2006

    *) Workaround: for bug in FreeBSD kqueue.

    *) Bugfix: now a response generated by the "post_action" directive is
       not transferred to a client.

    *) Bugfix: the memory leaks were occurring if many log files were used.

    *) Bugfix: the first "proxy_redirect" directive was working inside one
       location.

    *) Bugfix: on 64-bit platforms segmentation fault may occurred on start
       if the many names were used in the "server_name" directives; the bug
       had appeared in 0.3.18.


Changes with nginx 0.3.23                                        24 Jan 2006

    *) Feature: the "optimize_host_names" directive.

    *) Bugfix: in using of the variables in the "path" and "alias"
       directives.

    *) Bugfix: the ngx_http_perl_module was incorrectly built on Linux and
       Solaris.


Changes with nginx 0.3.22                                        17 Jan 2006

    *) Feature: the ngx_http_perl_module supports the $r->args and
       $r->unescape methods.

    *) Feature: the method $r->query_string of ngx_http_perl_module was
       canceled.

    *) Bugfix: segmentation fault was occurred if the "none" or "blocked"
       values was specified in the "valid_referers" directive; the bug had
       appeared in 0.3.18.


Changes with nginx 0.3.21                                        16 Jan 2006

    *) Feature: the ngx_http_perl_module.

    *) Change: the "valid_referers" directive allows the referrers without
       URI part.


Changes with nginx 0.3.20                                        11 Jan 2006

    *) Bugfix: in SSI handling.

    *) Bugfix: the ngx_http_memcached_module did not support the keys in the
       "/usr?args" form.


Changes with nginx 0.3.19                                        28 Dec 2005

    *) Feature: the "path" and "alias" directives support the variables.

    *) Change: now the "valid_referers" directive again checks the URI part.

    *) Bugfix: in SSI handling.


Changes with nginx 0.3.18                                        26 Dec 2005

    *) Feature: the "server_names" directive supports the ".domain.tld"
       names.

    *) Feature: the "server_names" directive uses the hash for the
       "*.domain.tld" names and more effective hash for usual names.

    *) Change: the "server_names_hash_max_size" and
       "server_names_hash_bucket_size" directives.

    *) Change: the "server_names_hash" and "server_names_hash_threshold"
       directives were canceled.

    *) Feature: the "valid_referers" directive uses the hash site names.

    *) Change: now the "valid_referers" directive checks the site names only
       without the URI part.

    *) Bugfix: some ".domain.tld" names incorrectly processed by the
       ngx_http_map_module.

    *) Bugfix: segmentation fault was occurred if configuration file did not
       exist; the bug had appeared in 0.3.12.

    *) Bugfix: on 64-bit platforms segmentation fault may occurred on start;
       the bug had appeared in 0.3.16.


Changes with nginx 0.3.17                                        18 Dec 2005

    *) Change: now on Linux configure checks the presence of epoll and
       sendfile64() in kernel.

    *) Feature: the "map" directive supports domain names in the
       ".domain.tld" form.

    *) Bugfix: the timeouts were not used in SSL handshake; the bug had
       appeared in 0.2.4.

    *) Bugfix: in the HTTPS protocol in the "proxy_pass" directive.

    *) Bugfix: when the HTTPS protocol was used in the "proxy_pass"
       directive the port 80 was used by default.


Changes with nginx 0.3.16                                        16 Dec 2005

    *) Feature: the ngx_http_map_module.

    *) Feature: the "types_hash_max_size" and "types_hash_bucket_size"
       directives.

    *) Feature: the "ssi_value_length" directive.

    *) Feature: the "worker_rlimit_core" directive.

    *) Workaround: the connection number in logs was always 1 if nginx was
       built by the icc 8.1 or 9.0 compilers with optimization for
       Pentium 4.

    *) Bugfix: the "config timefmt" SSI command set incorrect time format.

    *) Bugfix: nginx did not close connection to IMAP/POP3 backend for the
       SSL connections; the bug had appeared in 0.3.13.
       Thanks to Rob Mueller.

    *) Bugfix: segmentation fault may occurred in at SSL shutdown; the bug
       had appeared in 0.3.13.


Changes with nginx 0.3.15                                        07 Dec 2005

    *) Feature: the new 444 code of the "return" directive to close
       connection.

    *) Feature: the "so_keepalive" directive in IMAP/POP3 proxy.

    *) Bugfix: if there are unclosed connection nginx now calls abort() only
       on graceful quit and active "debug_points" directive.


Changes with nginx 0.3.14                                        05 Dec 2005

    *) Bugfix: in the 304 response the body was transferred; the bug had
       appeared in 0.3.13.


Changes with nginx 0.3.13                                        05 Dec 2005

    *) Feature: the IMAP/POP3 proxy supports STARTTLS and STLS.

    *) Bugfix: the IMAP/POP3 proxy did not work with the select, poll, and
       /dev/poll methods.

    *) Bugfix: in SSI handling.

    *) Bugfix: now Solaris sendfilev() is not used to transfer the client
       request body to FastCGI-server via the unix domain socket.

    *) Bugfix: the "auth_basic" directive did not disable the authorization;
       the bug had appeared in 0.3.11.


Changes with nginx 0.3.12                                        26 Nov 2005

    *) Security: if nginx was built with the ngx_http_realip_module and the
       "satisfy_any on" directive was used, then access and authorization
       directives did not work. The ngx_http_realip_module was not built and
       is not built by default.

    *) Change: the "$time_gmt" variable name was changed to "$time_local".

    *) Change: the "proxy_header_buffer_size" and
       "fastcgi_header_buffer_size" directives was renamed to the
       "proxy_buffer_size" and "fastcgi_buffer_size" directives.

    *) Feature: the ngx_http_memcached_module.

    *) Feature: the "proxy_buffering" directive.

    *) Bugfix: the changes in accept mutex handling when the "rtsig" method
       was used; the bug had appeared in 0.3.0.

    *) Bugfix: if the client sent the "Transfer-Encoding: chunked" header
       line, then nginx returns the 411 error.

    *) Bugfix: if the "auth_basic" directive was inherited from the http
       level, then the realm in the "WWW-Authenticate" header line was
       without the "Basic realm" text.

    *) Bugfix: if the "combined" format was explicitly specified in the
       "access_log" directive, then the empty lines was written to the log;
       the bug had appeared in 0.3.8.

    *) Bugfix: nginx did not run on the sparc platform under any OS except
       Solaris.

    *) Bugfix: now it is not necessary to place space between the quoted
       string and closing bracket in the "if" directive.


Changes with nginx 0.3.11                                        15 Nov 2005

    *) Bugfix: nginx did not pass the client request headers and body while
       proxying; the bug had appeared in 0.3.10.


Changes with nginx 0.3.10                                        15 Nov 2005

    *) Change: the "valid_referers" directive and the "$invalid_referer"
       variable were moved to the new ngx_http_referer_module from the
       ngx_http_rewrite_module.

    *) Change: the "$apache_bytes_sent" variable name was changed to
       "$body_bytes_sent".

    *) Feature: the "$sent_http_..." variables.

    *) Feature: the "if" directive supports the "=" and "!=" operations.

    *) Feature: the "proxy_pass" directive supports the HTTPS protocol.

    *) Feature: the "proxy_set_body" directive.

    *) Feature: the "post_action" directive.

    *) Feature: the ngx_http_empty_gif_module.

    *) Feature: the "worker_cpu_affinity" directive for Linux.

    *) Bugfix: the "rewrite" directive did not unescape URI part in
       redirect, now it is unescaped except the %00-%25 and %7F-%FF
       characters.

    *) Bugfix: nginx could not be built by the icc 9.0 compiler.

    *) Bugfix: if the SSI was enabled for zero size static file, then the
       chunked response was encoded incorrectly.


Changes with nginx 0.3.9                                         10 Nov 2005

    *) Bugfix: nginx considered URI as unsafe if two any symbols was between
       two slashes; the bug had appeared in 0.3.8.


Changes with nginx 0.3.8                                         09 Nov 2005

    *) Security: nginx now checks URI got from a backend in
       "X-Accel-Redirect" header line or in SSI file for the "/../" paths
       and zeroes.

    *) Change: nginx now does not treat the empty user name in the
       "Authorization" header line as valid one.

    *) Feature: the "ssl_session_timeout" directives of the
       ngx_http_ssl_module and ngx_imap_ssl_module.

    *) Feature: the "auth_http_header" directive of the
       ngx_imap_auth_http_module.

    *) Feature: the "add_header" directive.

    *) Feature: the ngx_http_realip_module.

    *) Feature: the new variables to use in the "log_format" directive:
       $bytes_sent, $apache_bytes_sent, $status, $time_gmt, $uri,
       $request_time, $request_length, $upstream_status,
       $upstream_response_time, $gzip_ratio, $uid_got, $uid_set,
       $connection, $pipe, and $msec. The parameters in the "%name" form
       will be canceled soon.

    *) Change: now the false variable values in the "if" directive are the
       empty string "" and string starting with "0".

    *) Bugfix: while using proxied or FastCGI-server nginx may leave
       connections and temporary files with client requests in open state.

    *) Bugfix: the worker processes did not flush the buffered logs on
       graceful exit.

    *) Bugfix: if the request URI was changes by the "rewrite" directive and
       the request was proxied in location given by regular expression, then
       the incorrect request was transferred to backend; the bug had
       appeared in 0.2.6.

    *) Bugfix: the "expires" directive did not remove the previous "Expires"
       header.

    *) Bugfix: nginx may stop to accept requests if the "rtsig" method and
       several worker processes were used.

    *) Bugfix: the "\"" and "\'" escape symbols were incorrectly handled in
       SSI commands.

    *) Bugfix: if the response was ended just after the SSI command and
       gzipping was used, then the response did not transferred complete or
       did not transferred at all.


Changes with nginx 0.3.7                                         27 Oct 2005

    *) Feature: the "access_log" supports the "buffer=" parameter.

    *) Bugfix: nginx could not be built on platforms different from i386,
       amd64, sparc, and ppc; the bug had appeared in 0.3.2.


Changes with nginx 0.3.6                                         24 Oct 2005

    *) Change: now the IMAP/POP3 proxy do not send the empty login to
       authorization server.

    *) Feature: the "log_format" supports the variables in the $name form.

    *) Bugfix: if at least in one server was no the "listen" directive, then
       nginx did not listen on the 80 port; the bug had appeared in 0.3.3.

    *) Bugfix: if the URI part is omitted in "proxy_pass" directive, the 80
       port was always used.


Changes with nginx 0.3.5                                         21 Oct 2005

    *) Bugfix: the segmentation fault may occurred if the IMAP/POP3 login
       was changed by authorization server; the bug had appeared in 0.2.2.

    *) Bugfix: the accept mutex did not work and all connections were
       handled by one process; the bug had appeared in 0.3.3.

    *) Bugfix: the timeout did not work if the "rtsig" method and the
       "timer_resolution" directive were used.


Changes with nginx 0.3.4                                         19 Oct 2005

    *) Bugfix: nginx could not be built on Linux 2.4+ and MacOS X; the bug
       had appeared in 0.3.3.


Changes with nginx 0.3.3                                         19 Oct 2005

    *) Change: the "bl" and "af" parameters of the "listen" directive was
       renamed to the "backlog" and "accept_filter".

    *) Feature: the "rcvbuf" and "sndbuf" parameters of the "listen"
       directive.

    *) Change: the "$msec" log parameter does not require now the additional
       the gettimeofday() system call.

    *) Feature: the -t switch now tests the "listen" directives.

    *) Bugfix: if the invalid address was specified in the "listen"
       directive, then after the -HUP signal nginx left an open socket in
       the CLOSED state.

    *) Bugfix: the mime type may be incorrectly set to default value for
       index file with variable in the name; the bug had appeared in 0.3.0.

    *) Feature: the "timer_resolution" directive.

    *) Feature: the millisecond "$upstream_response_time" log parameter.

    *) Bugfix: a temporary file with client request body now is removed just
       after the response header was transferred to a client.

    *) Bugfix: OpenSSL 0.9.6 compatibility.

    *) Bugfix: the SSL certificate and key file paths could not be relative.

    *) Bugfix: the "ssl_prefer_server_ciphers" directive did not work in the
       ngx_imap_ssl_module.

    *) Bugfix: the "ssl_protocols" directive allowed to specify the single
       protocol only.


Changes with nginx 0.3.2                                         12 Oct 2005

    *) Feature: the Sun Studio 10 C compiler support.

    *) Feature: the "proxy_upstream_max_fails",
       "proxy_upstream_fail_timeout", "fastcgi_upstream_max_fails", and
       "fastcgi_upstream_fail_timeout" directives.


Changes with nginx 0.3.1                                         10 Oct 2005

    *) Bugfix: the segmentation fault occurred when the signal queue
       overflowed if the "rtsig" method was used; the bug had appeared in
       0.2.0.

    *) Change: correct handling of the "\\", "\"", "\'", and "\$" pairs in
       SSI.


Changes with nginx 0.3.0                                         07 Oct 2005

    *) Change: the 10-days live time limit of worker process was eliminated.
       The limit was introduced because of millisecond timers overflow.


Changes with nginx 0.2.6                                         05 Oct 2005

    *) Change: while using load-balancing the time before the failed backend
       retry was decreased from 60 to 10 seconds.

    *) Change: the "proxy_pass_unparsed_uri" was canceled, the original URI
       now passed, if the URI part is omitted in "proxy_pass" directive.

    *) Feature: the "error_page" directive supports redirects and allows
       more flexible to change an error code.

    *) Change: the charset in the "Content-Type" header line now is ignored
       in proxied subrequests.

    *) Bugfix: if the URI was changed in the "if" block and request did not
       found new configuration, then the ngx_http_rewrite_module rules ran
       again.

    *) Bugfix: if the "set" directive set the ngx_http_geo_module variable
       in some configuration part, the this variable was not available in
       other configuration parts and the "using uninitialized variable"
       error was occurred; the bug had appeared in 0.2.2.


Changes with nginx 0.2.5                                         04 Oct 2005

    *) Change: the duplicate value of the ngx_http_geo_module variable now
       causes the warning and changes old value.

    *) Feature: the ngx_http_ssi_module supports the "set" command.

    *) Feature: the ngx_http_ssi_module supports the "file" parameter in the
       "include" command.

    *) Feature: the ngx_http_ssi_module supports the variable value
       substitutions in expressions of the "if" command.


Changes with nginx 0.2.4                                         03 Oct 2005

    *) Feature: the ngx_http_ssi_module supports "$var=text", "$var!=text",
       "$var=/text/", and "$var!=/text/" expressions in the "if" command.

    *) Bugfix: in proxying location without trailing slash; the bug had
       appeared in 0.1.44.

    *) Bugfix: the segmentation fault may occurred if the "rtsig" method was
       used; the bug had appeared in 0.2.0.


Changes with nginx 0.2.3                                         30 Sep 2005

    *) Bugfix: nginx could not be built without the --with-debug option; the
       bug had appeared in 0.2.2.


Changes with nginx 0.2.2                                         30 Sep 2005

    *) Feature: the "config errmsg" command of the ngx_http_ssi_module.

    *) Change: the ngx_http_geo_module variables can be overridden by the
       "set" directive.

    *) Feature: the "ssl_protocols" and "ssl_prefer_server_ciphers"
       directives of the ngx_http_ssl_module and ngx_imap_ssl_module.

    *) Bugfix: the ngx_http_autoindex_module did not show correctly the long
       file names;

    *) Bugfix: the ngx_http_autoindex_module now do not show the files
       starting by dot.

    *) Bugfix: if the SSL handshake failed then another connection may be
       closed too.
       Thanks to Rob Mueller.

    *) Bugfix: the export versions of MSIE 5.x could not connect via HTTPS.


Changes with nginx 0.2.1                                         23 Sep 2005

    *) Bugfix: if all backend using in load-balancing failed after one
       error, then nginx may got caught in an endless loop; the bug had
       appeared in 0.2.0.


Changes with nginx 0.2.0                                         23 Sep 2005

    *) The pid-file names used during online upgrade was changed and now is
       not required a manual rename operation. The old master process adds
       the ".oldbin" suffix to its pid-file and executes a new binary file.
       The new master process creates usual pid-file without the ".newbin"
       suffix. If the master process exits, then old master process renames
       back its pid-file with the ".oldbin" suffix to the pid-file without
       suffix.

    *) Change: the "worker_connections" directive, new name of the
       "connections" directive; now the directive specifies maximum number
       of connections, but not maximum socket descriptor number.

    *) Feature: SSL supports the session cache inside one worker process.

    *) Feature: the "satisfy_any" directive.

    *) Change: the ngx_http_access_module and ngx_http_auth_basic_module do
       not run for subrequests.

    *) Feature: the "worker_rlimit_nofile" and "worker_rlimit_sigpending"
       directives.

    *) Bugfix: if all backend using in load-balancing failed after one
       error, then nginx did not try do connect to them during 60 seconds.

    *) Bugfix: in IMAP/POP3 command argument parsing.
       Thanks to Rob Mueller.

    *) Bugfix: errors while using SSL in IMAP/POP3 proxy.

    *) Bugfix: errors while using SSI and gzipping.

    *) Bugfix: the "Expires" and "Cache-Control" header lines were omitted
       from the 304 responses.
       Thanks to Alexandr Kukushkin.


Changes with nginx 0.1.45                                        08 Sep 2005

    *) Change: the "ssl_engine" directive was canceled in the
       ngx_http_ssl_module and now is introduced at global level.

    *) Bugfix: the responses with SSI subrequests did not transferred via
       SSL connection.

    *) Various bug fixes in the IMAP/POP3 proxy.


Changes with nginx 0.1.44                                        06 Sep 2005

    *) Feature: the IMAP/POP3 proxy supports SSL.

    *) Feature: the "proxy_timeout" directive of the ngx_imap_proxy_module.

    *) Feature: the "userid_mark" directive.

    *) Feature: the $remote_user variable value is determined independently
       of authorization use.


Changes with nginx 0.1.43                                        30 Aug 2005

    *) Feature: the listen(2) backlog in the "listen" directive can be
       changed using the -HUP signal.

    *) Feature: the geo2nginx.pl script was added to contrib.

    *) Change: the FastCGI parameters with the empty values now are passed
       to a server.

    *) Bugfix: the segmentation fault occurred or the worker process may got
       caught in an endless loop if the proxied or FastCGI server sent the
       "Cache-Control" header line and the "expires" directive was used; in
       the proxied mode the bug had appeared in 0.1.29.


Changes with nginx 0.1.42                                        23 Aug 2005

    *) Bugfix: if the request URI had a zero length after the processing in
       the ngx_http_proxy_module, then the segmentation fault or bus error
       occurred in the ngx_http_proxy_module.

    *) Bugfix: the "limit_rate" directive did not work inside the "if"
       block; the bug had appeared in 0.1.38.


Changes with nginx 0.1.41                                        25 Jul 2005

    *) Bugfix: if the variable was used in the configuration file, then it
       can not be used in SSI.


Changes with nginx 0.1.40                                        22 Jul 2005

    *) Bugfix: if a client sent too long header line, then the request
       information did not logged in the error log.

    *) Bugfix: the "Set-Cookie" header line was not transferred when the
       "X-Accel-Redirect" was used; the bug had appeared in 0.1.39.

    *) Bugfix: the "Content-Disposition" header line was not transferred
       when the "X-Accel-Redirect" was used.

    *) Bugfix: the master process did not close the listen socket on the
       SIGQUIT signal.

    *) Bugfix: after on-line upgrade on Linux and Solaris the process name
       became shorter in the "ps" command.


Changes with nginx 0.1.39                                        14 Jul 2005

    *) The changes in the ngx_http_charset_module: the "default_charset"
       directive was canceled; the "charset" directive sets the response
       charset; the "source_charset" directive sets the source charset only.

    *) Bugfix: the backend "WWW-Authenticate" header line did not
       transferred while the 401 response code redirecting.

    *) Bugfix: the ngx_http_proxy_module and ngx_http_fastcgi_module may
       close a connection before anything was transferred to a client; the
       bug had appeared in 0.1.38.

    *) Workaround: the Linux glibc crypt_r() initialization bug.

    *) Bugfix: the ngx_http_ssi_module did not support the relative URI in
       the "include virtual" command.

    *) Bugfix: if the backend response had the "Location" header line and
       nginx should not rewrite this line, then the 500 code response body
       was transferred; the bug had appeared in 0.1.29.

    *) Bugfix: some directives of the ngx_http_proxy_module and
       ngx_http_fastcgi_module were not inherited from the server to the
       location level; the bug had appeared in 0.1.29.

    *) Bugfix: the ngx_http_ssl_module did not support the certificate
       chain.

    *) Bugfix: the ngx_http_autoindex_module did not show correctly the long
       file names; the bug had appeared in 0.1.38.

    *) Bugfixes in IMAP/POP3 proxy in interaction with a backend at the
       login state.


Changes with nginx 0.1.38                                        08 Jul 2005

    *) Feature: the "limit_rate" directive is supported in proxy and FastCGI
       mode.

    *) Feature: the "X-Accel-Limit-Rate" response header line is supported
       in proxy and FastCGI mode.

    *) Feature: the "break" directive.

    *) Feature: the "log_not_found" directive.

    *) Bugfix: the response status code was not changed when request was
       redirected by the ""X-Accel-Redirect" header line.

    *) Bugfix: the variables set by the "set" directive could not be used in
       SSI.

    *) Bugfix: the segmentation fault may occurred if the SSI page has more
       than one remote subrequest.

    *) Bugfix: nginx treated the backend response as invalid if the status
       line in the header was transferred in two packets; the bug had
       appeared in 0.1.29.

    *) Feature: the "ssi_types" directive.

    *) Feature: the "autoindex_exact_size" directive.

    *) Bugfix: the ngx_http_autoindex_module did not support the long file
       names in UTF-8.

    *) Feature: the IMAP/POP3 proxy.


Changes with nginx 0.1.37                                        23 Jun 2005

    *) Change: now the "\n" is added to the end of the "nginx.pid" file.

    *) Bugfix: the responses may be transferred not completely, if many
       parts or the big parts were included by SSI.

    *) Bugfix: if all backends had returned the 404 response and the
       "http_404" parameter of the "proxy_next_upstream" or
       "fastcgi_next_upstream" directives was used, then nginx started to
       request all backends again.


Changes with nginx 0.1.36                                        15 Jun 2005

    *) Change: if the request header has duplicate the "Host", "Connection",
       "Content-Length", or "Authorization" lines, then nginx now returns
       the 400 error.

    *) Change: the "post_accept_timeout" directive was canceled.

    *) Feature: the "default", "af=", "bl=", "deferred", and "bind"
       parameters of the "listen" directive.

    *) Feature: the FreeBSD accept filters support.

    *) Feature: the Linux TCP_DEFER_ACCEPT support.

    *) Bugfix: the ngx_http_autoindex_module did not support the file names
       in UTF-8.

    *) Bugfix: the new log file can be rotated by the -USR1 signal only if
       the reconfiguration by the -HUP signal was made twice.


Changes with nginx 0.1.35                                        07 Jun 2005

    *) Feature: the "working_directory" directive.

    *) Feature: the "port_in_redirect" directive.

    *) Bugfix: the segmentation fault was occurred if the backend response
       header was in several packets; the bug had appeared in 0.1.29.

    *) Bugfix: if more than 10 servers were configured or some server did
       not use the "listen" directive, then the segmentation fault was
       occurred on the start.

    *) Bugfix: the segmentation fault might occur if the response was bigger
       than the temporary file.

    *) Bugfix: nginx returned the 400 response on requests like
       "GET http://www.domain.com/uri HTTP/1.0"; the bug had appeared in
       0.1.28.


Changes with nginx 0.1.34                                        26 May 2005

    *) Bugfix: the worker process may got caught in an endless loop if the
       big response part were include by SSI.

    *) Bugfix: the variables set by the "set" directive were not available
       in SSI.

    *) Feature: the "autoindex_localtime" directive.

    *) Bugfix: the empty value of the "proxy_set_header" directive forbids
       the client request header line passing.


Changes with nginx 0.1.33                                        23 May 2005

    *) Bugfix: nginx could not be built with the --without-pcre parameter;
       the bug had appeared in 0.1.29.

    *) Bugfix: 3, 4, 7, and 8 the "proxy_set_header" directives in one level
       cause the bus fault on start up.

    *) Bugfix: the HTTP protocol was specified in the HTTPS redirects.

    *) Bugfix: if the "rewrite" directive used the captures inside the "if"
       directive, then the 500 error code was returned.


Changes with nginx 0.1.32                                        19 May 2005

    *) Bugfix: the arguments were omitted in the redirects, issued by the
       "rewrite" directive; the bug had appeared in 0.1.29.

    *) Feature: the "if" directive supports the captures in regular
       expressions.

    *) Feature: the "set" directive supports the variables and the captures
       of regular expressions.

    *) Feature: the "X-Accel-Redirect" response header line is supported in
       proxy and FastCGI mode.


Changes with nginx 0.1.31                                        16 May 2005

    *) Bugfix: the response encrypted by SSL may not transferred complete.

    *) Bugfix: errors while processing FastCGI response by SSI.

    *) Bugfix: errors while using SSI and gzipping.

    *) Bugfix: the redirect with the 301 code was transferred without
       response body; the bug had appeared in 0.1.30.


Changes with nginx 0.1.30                                        14 May 2005

    *) Bugfix: the worker process may got caught in an endless loop if the
       SSI was used.

    *) Bugfix: the response encrypted by SSL may not transferred complete.

    *) Bugfix: if the length of the response part received at once from
       proxied or FastCGI server was equal to 500, then nginx returns the
       500 response code; in proxy mode the bug had appeared in 0.1.29 only.

    *) Bugfix: nginx did not consider the directives with 8 or 9 parameters
       as invalid.

    *) Feature: the "return" directive can return the 204 response code.

    *) Feature: the "ignore_invalid_headers" directive.


Changes with nginx 0.1.29                                        12 May 2005

    *) Feature: the ngx_http_ssi_module supports "include virtual" command.

    *) Feature: the ngx_http_ssi_module supports the condition command like
       'if expr="$NAME"' and "else" and "endif" commands. Only one nested
       level is supported.

    *) Feature: the ngx_http_ssi_module supports the DATE_LOCAL and DATE_GMT
       variables and "config timefmt" command.

    *) Feature: the "ssi_ignore_recycled_buffers" directive.

    *) Bugfix: the "echo" command did not show the default value for the
       empty QUERY_STRING variable.

    *) Change: the ngx_http_proxy_module was rewritten.

    *) Feature: the "proxy_redirect", "proxy_pass_request_headers",
       "proxy_pass_request_body", and "proxy_method" directives.

    *) Feature: the "proxy_set_header" directive. The "proxy_x_var" was
       canceled and must be replaced with the proxy_set_header directive.

    *) Change: the "proxy_preserve_host" is canceled and must be replaced
       with the "proxy_set_header Host $host" and the "proxy_redirect off"
       directives, the "proxy_set_header Host $host:$proxy_port" directive
       and the appropriate proxy_redirect directives.

    *) Change: the "proxy_set_x_real_ip" is canceled and must be replaced
       with the "proxy_set_header X-Real-IP $remote_addr" directive.

    *) Change: the "proxy_add_x_forwarded_for" is canceled and must be
       replaced with
       the "proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for"
       directive.

    *) Change: the "proxy_set_x_url" is canceled and must be replaced with
       the "proxy_set_header X-URL http://$host:$server_port$request_uri"
       directive.

    *) Feature: the "fastcgi_param" directive.

    *) Change: the "fastcgi_root", "fastcgi_set_var" and "fastcgi_params"
       directive are canceled and must be replaced with the fastcgi_param
       directives.

    *) Feature: the "index" directive can use the variables.

    *) Feature: the "index" directive can be used at http and server levels.

    *) Change: the last index only in the "index" directive can be absolute.

    *) Feature: the "rewrite" directive can use the variables.

    *) Feature: the "internal" directive.

    *) Feature: the CONTENT_LENGTH, CONTENT_TYPE, REMOTE_PORT, SERVER_ADDR,
       SERVER_PORT, SERVER_PROTOCOL, DOCUMENT_ROOT, SERVER_NAME,
       REQUEST_METHOD, REQUEST_URI, and REMOTE_USER variables.

    *) Change: nginx now passes the invalid lines in a client request
       headers or a backend response header.

    *) Bugfix: if the backend did not transfer response for a long time and
       the "send_timeout" was less than "proxy_read_timeout", then nginx
       returned the 408 response.

    *) Bugfix: the segmentation fault was occurred if the backend sent an
       invalid line in response header; the bug had appeared in 0.1.26.

    *) Bugfix: the segmentation fault may occurred in FastCGI fault
       tolerance configuration.

    *) Bugfix: the "expires" directive did not remove the previous "Expires"
       and "Cache-Control" headers.

    *) Bugfix: nginx did not take into account trailing dot in "Host" header
       line.

    *) Bugfix: the ngx_http_auth_module did not work under Linux.

    *) Bugfix: the rewrite directive worked incorrectly, if the arguments
       were in a request.

    *) Bugfix: nginx could not be built on MacOS X.


Changes with nginx 0.1.28                                        08 Apr 2005

    *) Bugfix: nginx hogs CPU while proxying the huge files.

    *) Bugfix: nginx could not be built by gcc 4.0 on Linux.


Changes with nginx 0.1.27                                        28 Mar 2005

    *) Feature: the "blocked" parameter of the "valid_referers" directive.

    *) Change: the errors while handling the request header now logged at
       "info" level. The server name and the "Host" and "Referer" header
       lines also logged.

    *) Change: the "Host" header line is also logged in error log.

    *) Feature: the proxy_pass_unparsed_uri directive. The special handling
       of the "://" symbols in URI, appeared in 0.1.11 version, now is
       canceled.

    *) Bugfix: nginx could not be built on FreeBSD and Linux, if the
       --without-ngx_http_auth_basic_module configuration parameter was
       used.


Changes with nginx 0.1.26                                        22 Mar 2005

    *) Change: the invalid client header lines are now ignored and logged at
       the info level.

    *) Change: the server name is also logged in error log.

    *) Feature: the ngx_http_auth_basic_module module and the auth_basic and
       auth_basic_user_file directives.


Changes with nginx 0.1.25                                        19 Mar 2005

    *) Bugfix: nginx did run on Linux parisc.

    *) Feature: nginx now does not start under FreeBSD if the sysctl
       kern.ipc.somaxconn value is too big.

    *) Bugfix: if a request was internally redirected by the
       ngx_http_index_module module to the ngx_http_proxy_module or
       ngx_http_fastcgi_module modules, then the index file was not closed
       after request completion.

    *) Feature: the "proxy_pass" can be used in location with regular
       expression.

    *) Feature: the ngx_http_rewrite_filter_module module supports the
       condition like "if ($HTTP_USER_AGENT ~ MSIE)".

    *) Bugfix: nginx started too slow if the large number of addresses and
       text values were used in the "geo" directive.

    *) Change: a variable name must be declared as "$name" in the "geo"
       directive. The previous variant without "$" is still supported, but
       will be removed soon.

    *) Feature: the "%{VARIABLE}v" logging parameter.

    *) Feature: the "set $name value" directive.

    *) Bugfix: gcc 4.0 compatibility.

    *) Feature: the --with-openssl-opt=OPTIONS autoconfiguration directive.


Changes with nginx 0.1.24                                        04 Mar 2005

    *) Feature: the ngx_http_ssi_filter_module supports the QUERY_STRING and
       DOCUMENT_URI variables.

    *) Bugfix: the ngx_http_autoindex_module may some times return the 404
       response for existent directory, if this directory was used in
       "alias" directive.

    *) Bugfix: the ngx_http_ssi_filter_module ran incorrectly for large
       responses.

    *) Bugfix: the lack of the "Referer" header line was always accounted as
       valid referrer.


Changes with nginx 0.1.23                                        01 Mar 2005

    *) Feature: the ngx_http_ssi_filter_module and the ssi,
       ssi_silent_errors, and ssi_min_file_chunk directives. The 'echo
       var="HTTP_..." default=""' and 'echo var="REMOTE_ADDR"' commands are
       supported.

    *) Feature: the %request_time log parameter.

    *) Feature: if the request has no the "Host" header line, then the
       "proxy_preserve_host" directive set this header line to the first
       server name of the "server_name" directive.

    *) Bugfix: nginx could not be built on platforms different from i386,
       amd64, sparc, and ppc; the bug had appeared in 0.1.22.

    *) Bugfix: the ngx_http_autoindex_module now shows the information not
       about the symlink, but about file or directory it points to.

    *) Bugfix: the %apache_length parameter logged the negative length of
       the response header if the no response was transferred to a client.


Changes with nginx 0.1.22                                        22 Feb 2005

    *) Bugfix: the ngx_http_stub_status_module showed incorrect handled
       connections statistics if the proxying or FastCGI server were used.

    *) Bugfix: the installation paths were incorrectly quoted on Linux and
       Solaris; the bug had appeared in 0.1.21.


Changes with nginx 0.1.21                                        22 Feb 2005

    *) Bugfix: the ngx_http_stub_status_module showed incorrect statistics
       if "rtsig" method was used or if several worker process ran on SMP.

    *) Bugfix: nginx could not be built by the icc compiler on Linux or if
       the zlib-1.2.x library was building from sources.

    *) Bugfix: nginx could not be built on NetBSD 2.0.


Changes with nginx 0.1.20                                        17 Feb 2005

    *) Feature: the new "script_filename" and "remote_port" parameters of
       the fastcgi_params directive.

    *) Bugfix: the FastCGI stderr stream was handled incorrectly.


Changes with nginx 0.1.19                                        16 Feb 2005

    *) Bugfix: now, if request contains the zero, then the 404 error is
       returned for the local requests.

    *) Bugfix: nginx could not be built on NetBSD 2.0.

    *) Bugfix: the timeout may occur while reading of the client request
       body via SSL connections.


Changes with nginx 0.1.18                                        09 Feb 2005

    *) Workaround: the default values of the devpoll_events and the
       devpoll_changes directives changed from 512 to 32 to be compatible
       with Solaris 10.

    *) Bugfix: the proxy_set_x_var and fastcgi_set_var directives were not
       inherited.

    *) Bugfix: in a redirect rewrite directive arguments were concatenated
       with URI by an "&" rather than a "?".

    *) Bugfix: the lines without trailing ";" in the file being included by
       the ngx_http_geo_module were silently ignored.

    *) Feature: the ngx_http_stub_status_module.

    *) Bugfix: the unknown log format in the access_log directive caused the
       segmentation fault.

    *) Feature: the new "document_root" parameter of the fastcgi_params
       directive.

    *) Feature: the fastcgi_redirect_errors directive.

    *) Feature: the new "break" modifier of the "rewrite" directive allows
       to stop the rewrite/location cycle and sets the current configuration
       to the request.


Changes with nginx 0.1.17                                        03 Feb 2005

    *) Change: the ngx_http_rewrite_module was rewritten from the scratch.
       Now it is possible to redirect, to return the error codes, to check
       the variables and referrers. The directives can be used inside
       locations. The redirect directive was canceled.

    *) Feature: the ngx_http_geo_module.

    *) Feature: the proxy_set_x_var and fastcgi_set_var directives.

    *) Bugfix: the location configuration with "=" modifier may be used in
       another location.

    *) Bugfix: the correct content type was set only for requests that use
       small caps letters in extension.

    *) Bugfix: if the proxy_pass or fastcgi_pass directives were set in the
       location, and access was denied, and the error was redirected to a
       static page, then the segmentation fault occurred.

    *) Bugfix: if in a proxied "Location" header was a relative URL, then a
       host name and a slash were added to them; the bug had appeared in
       0.1.14.

    *) Bugfix: the system error message was not logged on Linux.


Changes with nginx 0.1.16                                        25 Jan 2005

    *) Bugfix: if the response were transferred by chunks, then on the HEAD
       request the final chunk was issued.

    *) Bugfix: the "Connection: keep-alive" header were issued, even if the
       keepalive_timeout directive forbade the keep-alive use.

    *) Bugfix: the errors in the ngx_http_fastcgi_module caused the
       segmentation faults.

    *) Bugfix: the compressed response encrypted by SSL may not transferred
       complete.

    *) Bugfix: the TCP-specific TCP_NODELAY, TCP_NOPUSH, and TCP_CORK
       options, are not used for the unix domain sockets.

    *) Feature: the rewrite directive supports the arguments rewriting.

    *) Bugfix: the response code 400 was returned for the POST request with
       the "Content-Length: 0" header; the bug had appeared in 0.1.14.


Changes with nginx 0.1.15                                        19 Jan 2005

    *) Bugfix: the error while the connecting to the FastCGI server caused
       segmentation fault.

    *) Bugfix: the correct handling of the regular expression, that has
       different number of the captures and substitutions.

    *) Feature: the location, that is passed to the FastCGI server, can be
       regular expression.

    *) Bugfix: the FastCGI's parameter REQUEST_URI is now passed with the
       arguments and in the original state.

    *) Bugfix: the ngx_http_rewrite_module module was required to be built
       to use the regular expressions in locations.

    *) Bugfix: the directive "proxy_preserve_host on" adds port 80 to the
       "Host" headers, if upstream listen on port 80; the bug had appeared
       in 0.1.14.

    *) Bugfix: the same paths in autoconfiguration parameters
       --http-client-body-temp-path=PATH and --http-proxy-temp-path=PATH, or
       --http-client-body-temp-path=PATH and --http-fastcgi-temp-path=PATH
       caused segmentation fault.


Changes with nginx 0.1.14                                        18 Jan 2005

    *) Feature: the autoconfiguration directives:
       --http-client-body-temp-path=PATH, --http-proxy-temp-path=PATH, and
       --http-fastcgi-temp-path=PATH

    *) Change: the directory name for the temporary files with the client
       request body is specified by directive client_body_temp_path, by
       default it is <prefix>/client_body_temp.

    *) Feature: the ngx_http_fastcgi_module and the directives:
       fastcgi_pass, fastcgi_root, fastcgi_index, fastcgi_params,
       fastcgi_connect_timeout, fastcgi_send_timeout, fastcgi_read_timeout,
       fastcgi_send_lowat, fastcgi_header_buffer_size, fastcgi_buffers,
       fastcgi_busy_buffers_size, fastcgi_temp_path,
       fastcgi_max_temp_file_size, fastcgi_temp_file_write_size,
       fastcgi_next_upstream, and fastcgi_x_powered_by.

    *) Bugfix: the "[alert] zero size buf" error; the bug had appeared in
       0.1.3.

    *) Change: the URI must be specified after the host name in the
       proxy_pass directive.

    *) Change: the %3F symbol in the URI was considered as the argument
       string start.

    *) Feature: the unix domain sockets support in the
       ngx_http_proxy_module.

    *) Feature: the ssl_engine and ssl_ciphers directives.
       Thanks to Sergey Skvortsov for SSL-accelerator.


Changes with nginx 0.1.13                                        21 Dec 2004

    *) Feature: the server_names_hash and server_names_hash_threshold
       directives.

    *) Bugfix: the *.domain.tld names in the "server_name" directive did not
       work.

    *) Bugfix: the %request_length log parameter logged the incorrect
       length.


Changes with nginx 0.1.12                                        06 Dec 2004

    *) Feature: the %request_length log parameter.

    *) Bugfix: when using the /dev/poll, select and poll on the platforms,
       where these methods may do the false reports, there may be the long
       delay when the request was passed via the keep-alive connection. It
       may be at least on Solaris when using the /dev/poll.

    *) Bugfix: the send_lowat directive is ignored on Linux because Linux
       does not support the SO_SNDLOWAT option.


Changes with nginx 0.1.11                                        02 Dec 2004

    *) Feature: the worker_priority directive.

    *) Change: both tcp_nopush and tcp_nodelay directives affect the
       transferred response.

    *) Bugfix: nginx did not call initgroups().
       Thanks to Andrew Sitnikov and Andrei Nigmatulin.

    *) Change: now the ngx_http_autoindex_module shows the file size in the
       bytes.

    *) Bugfix: the ngx_http_autoindex_module returned the 500 error if the
       broken symlink was in a directory.

    *) Bugfix: the files bigger than 4G could not be transferred using
       sendfile.

    *) Bugfix: if the backend was resolved to several backends and there was
       an error while the response waiting then process may got caught in an
       endless loop.

    *) Bugfix: the worker process may exit with the "unknown cycle" message
       when the /dev/poll method was used.

    *) Bugfix: "close() channel failed" errors.

    *) Bugfix: the autodetection of the "nobody" and "nogroup" groups.

    *) Bugfix: the send_lowat directive did not work on Linux.

    *) Bugfix: the segmentation fault occurred if there was no events
       section in configuration.

    *) Bugfix: nginx could not be built on OpenBSD.

    *) Bugfix: the double slashes in "://" in the URI were converted to
       ":/".


Changes with nginx 0.1.10                                        26 Nov 2004

    *) Bugfix: if the request without arguments contains "//", "/./", "/../"
       or "%XX" then the last character in the request line was lost; the
       bug had appeared in 0.1.9.

    *) Bugfix: the fix in 0.1.9 for the files bigger than 2G on Linux did
       not work.


Changes with nginx 0.1.9                                         25 Nov 2004

    *) Bugfix: the proxied request was sent without arguments if the request
       contains "//", "/./", "/../" or "%XX".

    *) Bugfix: the large compressed responses may be transferred not
       completely.

    *) Bugfix: the files bigger than 2G was not transferred on Linux that
       does not support sendfile64().

    *) Bugfix: while the build configuration on Linux the --with-poll_module
       parameter was required; the bug had appeared in 0.1.8.


Changes with nginx 0.1.8                                         20 Nov 2004

    *) Bugfix: in the ngx_http_autoindex_module if the long file names were
       in the listing.

    *) Feature: the "^~" modifier in the location directive.

    *) Feature: the proxy_max_temp_file_size directive.


Changes with nginx 0.1.7                                         12 Nov 2004

    *) Bugfix: on FreeBSD the segmentation fault may occur if the size of
       the transferred file was changed; the bug had appeared in 0.1.5.


Changes with nginx 0.1.6                                         11 Nov 2004

    *) Bugfix: some location directive combinations with the regular
       expressions caused the wrong configuration choose.


Changes with nginx 0.1.5                                         11 Nov 2004

    *) Bugfix: on Solaris and Linux there may be too many "recvmsg()
       returned not enough data" alerts.

    *) Bugfix: there were the "writev() failed (22: Invalid argument)"
       errors on Solaris in proxy mode without sendfile. On other platforms
       that do not support sendfile at all the process got caught in an
       endless loop.

    *) Bugfix: segmentation fault on Solaris in proxy mode and using
       sendfile.

    *) Bugfix: segmentation fault on Solaris.

    *) Bugfix: on-line upgrade did not work on Linux.

    *) Bugfix: the ngx_http_autoindex_module module did not escape the
       spaces, the quotes, and the percent signs in the directory listing.

    *) Change: the decrease of the copy operations.

    *) Feature: the userid_p3p directive.


Changes with nginx 0.1.4                                         26 Oct 2004

    *) Bugfix: in the ngx_http_autoindex_module.


Changes with nginx 0.1.3                                         25 Oct 2004

    *) Feature: the ngx_http_autoindex_module and the autoindex directive.

    *) Feature: the proxy_set_x_url directive.

    *) Bugfix: proxy module may get caught in an endless loop when sendfile
       is not used.


Changes with nginx 0.1.2                                         21 Oct 2004

    *) Feature: the --user=USER, --group=GROUP, and --with-ld-opt=OPTIONS
       options in configure.

    *) Feature: the server_name directive supports *.domain.tld.

    *) Bugfix: the portability improvements.

    *) Bugfix: if configuration file was set in command line, the
       reconfiguration was impossible; the bug had appeared in 0.1.1.

    *) Bugfix: proxy module may get caught in an endless loop when sendfile
       is not used.

    *) Bugfix: with sendfile the response was not recoded according to the
       charset module directives; the bug had appeared in 0.1.1.

    *) Bugfix: very seldom bug in the kqueue processing.

    *) Bugfix: the gzip module compressed the proxied responses that was
       already compressed.


Changes with nginx 0.1.1                                         11 Oct 2004

    *) Feature: the gzip_types directive.

    *) Feature: the tcp_nodelay directive.

    *) Feature: the send_lowat directive is working not only on OSes that
       support kqueue NOTE_LOWAT, but also on OSes that support SO_SNDLOWAT.

    *) Feature: the setproctitle() emulation for Linux and Solaris.

    *) Bugfix: the "Location" header rewrite bug fixed while the proxying.

    *) Bugfix: the ngx_http_chunked_module module may get caught in an
       endless loop.

    *) Bugfix: the /dev/poll module bugs fixed.

    *) Bugfix: the responses were corrupted when the temporary files were
       used while the proxying.

    *) Bugfix: the unescaped requests were passed to the backend.

    *) Bugfix: while the build configuration on Linux 2.4 the
       --with-poll_module parameter was required.


Changes with nginx 0.1.0                                         04 Oct 2004

    *) The first public version.
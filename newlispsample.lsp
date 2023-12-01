#!/usr/bin/env newlisp

; As an example enter either a dotted IP-number:
;   208.94.116.204
; or a domain:
;   www.newlisp.org
;
;
; For faster performance convert the database to an array and do a 
; binary-search. For the web the simple 'find' used here, is adequate,
; as most of the time is spent loading the 4 Mbyte database.

(module "cgi.lsp")

; load the database
(load "IpToCountry.lsp")

(print  "Content-Type: text/html\r\n\r\n")

(define (has-ip ip rec)
	(and (>= ip (rec 0)) (<= ip (rec 1)))
)

(define (ip-to-country ip-str , ip-no)
	(set 'ip-no (first (unpack ">lu" (pack "bbbb" (map int (parse ip-str "."))))))
	(if (find ip-no IpToCountry has-ip) (last $0) "unknown")
)

(when (CGI:get "ipno")
	(set 'ip-str (CGI:get "ipno"))
	(unless (find {\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}} ip-str 0)
		(set 'ip-str (net-lookup ip-str)))
	(if ip-str 	
		(set 'country (ip-to-country ip-str)) 
		(set 'country "unknown domain"))
	(println (CGI:get "ipno") " : " country 
		"<br><br><a href=ip-to-country.html>back</a>")
)
	
(exit)

;---------------------------- get and convert the database -------------------

; use this code to create IpToCountry.lsp
; to get the latest IpToCountry.csv do a:
; (write-file "IpToCountry.csv.gz" (get-url "http://software77.net/geo-ip?DL=1"))

(set 'file (open "IpToCountry.csv" "read"))
(while (set 'line (read-line file))
	(unless (starts-with line "#")
		(set 'rec (parse (replace {"} line "") ","))
		(push (list (int (rec 0)) (int (rec 1)) (rec -1)) IpToCountry))
)

(close file)
(save "IpToCountry.lsp" 'IpToCountry)

(exit)

;---------------------------- the HTML form used in the example --------------

<html>
<head><title>IP to country</title></head>
<body>
<form name="geoip" action="ip-to-country.cgi" method="POST">
Dotted IP or domain:&nbsp;<input type="text" name="ipno" size="16">
&nbsp;<input type="submit" value="Submit" name="submit">
</form>
<a href=ip-to-country.txt>source</a>&nbsp;&nbsp;
<a href=http://www.nuevatec.com/syntax.cgi?ip-to-country.txt>source</a>
</body></html>

; eof

type=post
title=Herunterladen des HTTPS-Server-Zertifikats
date=2013-04-21 08:20
comments=true
external-url:
tags=https,zertifikat
~~~~~~

Herunterladen des HTTPS-Server-Zertifikats über die Kommandozeile
=================================================================

Den Trick habe ich von einem [EclipseSource-Blog](http://eclipsesource.com/blogs/2013/04/19/installing-eclipse-plug-ins-from-an-update-site-with-a-self-signed-certificate/):

*Listing: Herunterladen eines Server-Zertifikats*

``` sh
echo -n | openssl s_client -connect HOST:PORTNUMBER | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > my-custom-cert.cert
```

Prima, das erspart mir künftig einiges an Rumklickerei im Browser.

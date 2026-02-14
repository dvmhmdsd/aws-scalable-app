#!/bin/bash
set -euo pipefail

dnf update -y
dnf install -y httpd

cat <<'HTML' > /var/www/html/index.html
<!doctype html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Scalable App</title>
  </head>
  <body>
    <h1>Scalable Web App</h1>
    <p>Served by an Auto Scaling instance.</p>
  </body>
</html>
HTML

systemctl enable httpd
systemctl restart httpd


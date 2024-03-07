# 자가 서명된 인증서를 생성합니다. 인증서는 365일 동안 유효하며, RSA 2048비트 키를 사용합니다.
# 이 과정에서 생성된 키 파일은 harbor.key 이며, 인증서 파일은 myweb.crt 입니다.
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout harbor.key -out myweb.crt \
    -subj "/CN=harbor.myweb.io"

# 새로운 개인 키(harbor.key)와 
# CSR(Certificate Signing Request, harbor.csr)을 생성합니다.
sudo openssl req -new -newkey rsa:2048 -nodes -keyout harbor.key -out harbor.csr \
    -subj "/CN=harbor.myweb.io"

# CSR을 사용하여 자가 서명된 인증서(harbor.myweb.io.crt)를 생성합니다. 
# 인증서는 365일 동안 유효합니다.
sudo openssl x509 -req -days 365 -signkey harbor.key -in harbor.csr -out harbor.myweb.io.crt

# 생성된 개인 키 파일의 권한을 변경하여, 읽기 권한을 추가합니다.
sudo chmod 644 harbor.key

# 쿠버네티스 시크릿을 생성합니다. 이 시크릿은 harbor-tls 라는 이름으로 저장되며,
# 위에서 생성한 키 파일(harbor.key)과 인증서 파일(harbor.myweb.io.crt)을 포함합니다.
kubectl create secret tls harbor-tls --key harbor.key --cert harbor.myweb.io.crt

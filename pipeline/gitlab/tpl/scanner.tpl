apiVersion: samma.io/v1  
kind: Scanner
metadata: 
  name: $NAME
  namespace: samma-io
spec: 
 target: $TARGET
 samma_io_id: "11111"
 scanners: [$SCANNER]
 samma_io_tags: 
      - proxy
      - demo
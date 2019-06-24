param([string]$url)
Start-BitsTransfer -Source $url -Destination './jar.jar'
java -jar ./jar.jar

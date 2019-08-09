#!/usr/bin/env python
import base64
data = r"/Td6WFoAAATm1rRGAgAhARYAAAB0L+WjAQCeH4sICMA2Rl0AA2N0NjQAHcvRCoIwFADQd79GW0E9NsF5lw1MnfO+6RYzu6tAMvz7qPdz6qAZ5JI6JpPelDPkjgahlqFtvBN7r8WYYIwztjoubrzp24RAUABxCJBfnlhxskzREBRFRcpXNHyxj/Kf3WYkG/TLsh/cTb3IYhDZG1M+dUau14ovzpS+ZvKOBvx5On5UtT1FXxDiLoKWAAAAAABY3YwVRBDWWgABtwGfAQAAZUUbHbHEZ/sCAAAAAARZWg=="
z = base64.b64decode(data, altchars="+/")
print(z)

with open("out.7z", "wb") as fh:
  fh.write(z)
print("Decoded bytes written to file: out.7z")
#!/bin/bash
address="1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa"
message="1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa"
signature="HCsBcgB+Wcm8kOGMH8IpNeg0H4gjCrlqwDf/GlSXphZGBYxm0QkKEPhh9DTJRp2IDNUhVr0FhP9qCqo2W0recNM="
result=$(bitcoin-cli verifymessage "$address" "$signature" "$message")
echo $result

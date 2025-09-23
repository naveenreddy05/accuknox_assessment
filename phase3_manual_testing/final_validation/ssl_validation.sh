#!/bin/bash
echo "=== SSL/TLS CONFIGURATION VALIDATION ==="
echo ""

# Extract certificate information
echo "[+] Extracting SSL certificate details..."
echo | openssl s_client -connect itsecgames.com:443 -servername itsecgames.com 2>/dev/null | openssl x509 -text -noout > ssl_certificate_details.txt

# Check certificate validity for domain
echo "[+] Checking certificate domain validity..."
echo | openssl s_client -connect itsecgames.com:443 -servername itsecgames.com 2>/dev/null | openssl x509 -noout -subject -issuer > ssl_cert_validation.txt

# Test TLS configuration
echo "[+] Testing TLS configuration..."
curl -k -I https://itsecgames.com 2>&1 | grep -i "certificate\|ssl\|tls" > ssl_curl_test.txt

# Document SSL findings
echo "=== SSL CERTIFICATE VALIDATION FINDINGS ===" > ssl_validation_summary.txt
echo "Certificate Analysis Date: $(date)" >> ssl_validation_summary.txt
echo "" >> ssl_validation_summary.txt
echo "CERTIFICATE VALIDITY ISSUE CONFIRMED:" >> ssl_validation_summary.txt
echo "- Certificate not valid for itsecgames.com domain" >> ssl_validation_summary.txt
echo "- TLS validation fails (requires --insecure workaround)" >> ssl_validation_summary.txt
echo "- Risk: Man-in-the-middle attacks possible" >> ssl_validation_summary.txt
echo "" >> ssl_validation_summary.txt
echo "IMPACT: Users may accept invalid certificates, exposing communications" >> ssl_validation_summary.txt

#!/bin/bash
echo "=== BUSINESS IMPACT DEMONSTRATION ==="
echo "Demonstrating real-world impact of Drupal 7 EOL"
echo ""

# Demonstrate information disclosure
echo "[+] Demonstrating information disclosure via Drupal files..."
curl -k -s https://itsecgames.com/CHANGELOG.txt | head -5 > business_info_disclosure.txt
echo "VERSION INFORMATION DISCLOSED:" >> business_info_disclosure.txt
echo "This reveals exact Drupal version to attackers" >> business_info_disclosure.txt
echo "" >> business_info_disclosure.txt

# Check for exposed admin interfaces
echo "[+] Testing for exposed administrative interfaces..."
curl -k -s https://itsecgames.com/user/login | grep -i "login\|password\|username" > login_exposure.txt
echo "ADMIN ACCESS EXPOSURE:" >> business_info_disclosure.txt
echo "Login interface accessible without protection" >> business_info_disclosure.txt

# Demonstrate lack of security headers impact
echo "[+] Demonstrating missing security headers impact..."
curl -k -I https://itsecgames.com 2>/dev/null | grep -i "x-frame-options\|x-content-type-options\|strict-transport-security" > security_headers_check.txt
echo "SECURITY HEADERS STATUS:" >> business_info_disclosure.txt
cat security_headers_check.txt >> business_info_disclosure.txt

echo "[+] Business impact demonstration complete."

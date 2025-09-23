#!/bin/bash
echo "=== SECURITY HEADERS IMPACT VALIDATION ==="
echo ""

# Test both HTTP and HTTPS sites for headers
echo "[+] Comparing security headers between HTTP and HTTPS..."
echo "HTTP SITE HEADERS:" > headers_comparison.txt
curl -I http://itsecgames.com 2>/dev/null | grep -i "x-frame\|x-content\|strict-transport\|content-security" >> headers_comparison.txt
echo "" >> headers_comparison.txt
echo "HTTPS SITE HEADERS:" >> headers_comparison.txt
curl -k -I https://itsecgames.com 2>/dev/null | grep -i "x-frame\|x-content\|strict-transport\|content-security" >> headers_comparison.txt

# Create clickjacking proof-of-concept
cat > clickjacking_poc.html << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <title>Clickjacking PoC - itsecgames.com</title>
</head>
<body>
    <h1>Clickjacking Vulnerability Demonstration</h1>
    <p>The HTTP site (port 80) is vulnerable to clickjacking attacks due to missing X-Frame-Options header.</p>
    
clear    <h2>Proof of Concept:</h2>
    <iframe src="http://itsecgames.com" width="800" height="600" style="opacity:0.5">
        This demonstrates that the site can be embedded in frames
    </iframe>
    
    <h2>Business Impact:</h2>
    <ul>
        <li>Attackers can overlay invisible frames</li>
        <li>Users can be tricked into clicking malicious content</li>
        <li>Session hijacking possible</li>
        <li>Credential theft via social engineering</li>
    </ul>
</body>
</html>
HTML

echo "[+] Clickjacking PoC created: clickjacking_poc.html"
echo "[+] Headers comparison completed: headers_comparison.txt"

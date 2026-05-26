#!/bin/bash
mkdir -p reports

DATE=$(date '+%Y-%m-%d %H:%M:%S')
REPORT="reports/report.txt"

echo "============================================================" > "$REPORT"
echo "  RAPPORT DE SÉCURITÉ — $DATE" >> "$REPORT"
echo "============================================================" >> "$REPORT"
echo "" >> "$REPORT"

echo "[ SSH ] Tentatives de connexion échouées :" >> "$REPORT"
echo "------------------------------------------------------------" >> "$REPORT"
if [ -f /var/log/auth.log ]; then
    COUNT=$(grep -c "Failed password" /var/log/auth.log 2>/dev/null || echo 0)
    echo "Nombre total : $COUNT" >> "$REPORT"
    grep "Failed password" /var/log/auth.log >> "$REPORT" 2>/dev/null
else
    echo "Fichier auth.log introuvable." >> "$REPORT"
fi

echo "" >> "$REPORT"
echo "[ NGINX ] Erreurs HTTP 404 :" >> "$REPORT"
echo "------------------------------------------------------------" >> "$REPORT"
if [ -f /var/log/nginx/access.log ]; then
    grep " 404 " /var/log/nginx/access.log >> "$REPORT" 2>/dev/null
else
    echo "Fichier access.log introuvable." >> "$REPORT"
fi

echo "" >> "$REPORT"
echo "============================================================" >> "$REPORT"
echo "  FIN DU RAPPORT" >> "$REPORT"
echo "============================================================" >> "$REPORT"

echo "[OK] Rapport généré : $REPORT"

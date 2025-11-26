# 🚀 Guia Rápido de Instalação do n8n na sua VPS

## ✅ Passo a Passo Simplificado

### 1️⃣ Conecte-se à sua VPS

Abra um terminal (PowerShell, CMD ou terminal Linux/Mac) e conecte-se via SSH:

```bash
ssh administrator@173.208.232.72 -p 22
```

Digite a senha quando solicitado.

### 2️⃣ Execute o Instalador (UM ÚNICO COMANDO!)

Copie e cole este comando completo na sua VPS:

```bash
curl -fsSL https://raw.githubusercontent.com/rodrigolopesto/n8n-installer/main/install-n8n.sh | sudo bash
```

**Pronto!** O script vai fazer tudo automaticamente:
- ✅ Atualizar o sistema
- ✅ Instalar Node.js
- ✅ Instalar n8n
- ✅ Configurar como serviço
- ✅ Abrir portas no firewall

### 3️⃣ Acesse o n8n

Após a instalação (leva cerca de 5-10 minutos), abra seu navegador e acesse:

```
http://173.208.232.72:5678
```

**Credenciais de acesso:**
- **Usuário:** admin
- **Senha:** admin123

---

## 🔐 IMPORTANTE: Altere a Senha!

Após o primeiro login, altere a senha padrão:

1. Pare o n8n:
```bash
pm2 stop n8n
```

2. Edite a configuração:
```bash
sudo nano /tmp/n8n-pm2.json
```

3. Altere as linhas:
```json
"N8N_BASIC_AUTH_USER": "seu_usuario",
"N8N_BASIC_AUTH_PASSWORD": "sua_senha_forte"
```

4. Salve (Ctrl+O, Enter, Ctrl+X) e reinicie:
```bash
pm2 restart n8n
```

---

## 📊 Comandos Úteis

```bash
# Ver se o n8n está rodando
pm2 status

# Ver logs em tempo real
pm2 logs n8n

# Reiniciar o n8n
pm2 restart n8n

# Parar o n8n
pm2 stop n8n

# Iniciar o n8n
pm2 start n8n
```

---

## 🆘 Problemas Comuns

### Não consigo acessar o n8n pelo navegador

1. Verifique se está rodando:
```bash
pm2 status
```

2. Verifique se a porta está aberta:
```bash
sudo ufw status
```

3. Se necessário, abra a porta manualmente:
```bash
sudo ufw allow 5678/tcp
```

### O script dá erro de permissão

Certifique-se de usar `sudo`:
```bash
curl -fsSL https://raw.githubusercontent.com/rodrigolopesto/n8n-installer/main/install-n8n.sh | sudo bash
```

---

## 📚 Recursos Adicionais

- [Documentação oficial do n8n](https://docs.n8n.io/)
- [Comunidade n8n](https://community.n8n.io/)
- [Repositório do instalador](https://github.com/rodrigolopesto/n8n-installer)

---

**Desenvolvido por Manus AI Assistant**

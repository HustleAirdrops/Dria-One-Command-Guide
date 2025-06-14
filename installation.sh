#!/bin/bash

# ─────────────────────────────────────────────────────────────
# 🚀 DRIA NODE INSTALLER + AUTO SETUP + AUTO START
# 🔧 By: ChatGPT X Aashi (Power User Mode)
# ─────────────────────────────────────────────────────────────

# 🧱 Step 1: Install Ollama
echo "📦 Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

# ─────────────────────────────────────────────────────────────

# 🧱 Step 2: Install Dria Launcher
echo "📦 Installing Dria Launcher..."
curl -fsSL https://dria.co/launcher | bash

# ─────────────────────────────────────────────────────────────

# 🛣️ Step 3: Add Dria to PATH (if not already)
echo "🔧 Updating PATH..."
grep -qxF 'export PATH="$HOME/.dria/bin:$PATH"' ~/.bashrc || echo 'export PATH="$HOME/.dria/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# ─────────────────────────────────────────────────────────────

# 🧠 Function to take input with visible typing, then hide line
get_input_and_hide() {
    local prompt="$1"
    local var_name="$2"

    echo -n "$prompt"
    read input

    # Hide the input line after pressing Enter (without clearing terminal)
    tput cuu1
    tput el

    eval $var_name="'$input'"
}

# ─────────────────────────────────────────────────────────────

# 🔐 Step 4: Ask for Private Key & Gemini API
get_input_and_hide "🔐 Enter your DRIA Private Key: " PRIVATE_KEY
get_input_and_hide "🔑 Enter your Gemini API Key: " GEMINI_KEY

# ─────────────────────────────────────────────────────────────

# 📝 Step 5: Generate .env File with Fixed Model
echo "📝 Creating environment file..."
mkdir -p ~/.dria/dkn-compute-launcher

cat > ~/.dria/dkn-compute-launcher/.env <<EOF
## DRIA ##
DKN_WALLET_SECRET_KEY=${PRIVATE_KEY}
DKN_MODELS=gemini-2.0-flash
DKN_P2P_LISTEN_ADDR=/ip4/0.0.0.0/tcp/4001
DKN_BATCH_SIZE=

## Ollama (if used, optional) ##
OLLAMA_HOST=http://127.0.0.1
OLLAMA_PORT=11434
OLLAMA_AUTO_PULL=true

## Open AI (if used, required) ##
OPENAI_API_KEY=

## Gemini (if used, required) ##
GEMINI_API_KEY=${GEMINI_KEY}

## Open Router (if used, required) ##
OPENROUTER_API_KEY=

## Log levels
RUST_LOG=none
EOF

# ─────────────────────────────────────────────────────────────

# 🚀 Step 6: Auto Start Node
echo "🚀 Starting Dria Node..."
dkn-compute-launcher start

# ─────────────────────────────────────────────────────────────

# ✅ Done
echo -e "\n✅ \033[1mDria Node setup complete!\033[0m"
echo -e "📡 Your node is now running.\n"

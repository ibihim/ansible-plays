# Inventory and playbook paths
INVENTORY       = inventory.ini
SERVER_PLAYBOOK = playbooks/server-setup.yml
MC_PLAYBOOK     = playbooks/minecraft.yml
COPY_CMD        = wl-copy

.PHONY: help server server-check minecraft minecraft-check

help:
	@echo "Usage:"
	@echo "  make server         - Run the server-setup playbook"
	@echo "  make server-check   - Dry-run (check mode) the server-setup playbook"
	@echo "  make minecraft      - Run the minecraft playbook"
	@echo "  make minecraft-check- Dry-run (check mode) the minecraft playbook"
	@echo "  make help           - Show this help message"

## server: Run the Ansible playbook on the 'server' group
server:
	ansible-playbook -i $(INVENTORY) $(SERVER_PLAYBOOK) --ask-become-pass

## server-check: Perform a 'dry run' of the server setup
server-check:
	ansible-playbook -i $(INVENTORY) $(SERVER_PLAYBOOK) --check

## minecraft: Run the Ansible playbook on the 'minecraft' group
minecraft:
	ansible-playbook -i $(INVENTORY) $(MC_PLAYBOOK) --ask-become-pass

## minecraft-check: Perform a 'dry run' of the minecraft playbook
minecraft-check:
	ansible-playbook -i $(INVENTORY) $(MC_PLAYBOOK) --check

copy-to-clipboard:
	@echo "Creating consolidated snippet to clipboard..."
	@( \
	  echo "Tree output"; \
	  echo "\`\`\`"; \
	  tree -I '.git'; \
	  echo "\`\`\`"; \
	  echo ""; \
	  echo "playbooks/minecraft.yml"; \
	  echo "\`\`\`yaml"; \
	  cat playbooks/minecraft.yml; \
	  echo "\`\`\`"; \
	  echo "playbooks/server-setup.yml"; \
	  echo "\`\`\`yaml"; \
	  cat playbooks/server-setup.yml; \
	  echo "\`\`\`"; \
	) | $(COPY_CMD)
	@echo "✅ Copied project tree + minecraft.yml,server-setup.yml to the clipboard."

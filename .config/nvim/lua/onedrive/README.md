# OneDrive Neovim Plug-in

## 1. Plug-ins installeren
Je hebt deze plug-ins nodig:
- `nvim-lua/plenary.nvim` (vereist)
- `ibhagwan/fzf-lua` **aanbevolen** voor de picker (kan Telescope fallbacken)

## 1. Configuratie
Voeg het volgende toe aan je Neovim-init (bijvoorbeeld in `init.lua` of via je plugin-manager):

```lua
require("onedrive").setup({
  client_id = "JOUW-CLIENT-ID-HIER",
  tenant    = "consumers",  -- gebruik dit voor je persoonlijke Microsoft-account
  -- Optionele parameters:
  -- scope      = "openid profile offline_access Files.ReadWrite",
  -- link_type  = "view",
  -- link_scope = "anonymous",
})
```

- `client_id`: de Application (Client) ID van je eerder geregistreerde app in Microsoft Entra.
- `tenant`: voor persoonlijke accounts gebruik je "consumers"; voor werk/school-accounts gebruik je je tenant-ID of "organizations".

## 3. Command: `:OneDrive`

- **Algemene zoekactie**
  - `:OneDrive` → prompt om een zoekterm in te voeren.
  - `:OneDrive project notulen` → zoekt direct in OneDrive.
  - **Resultaat selecteren** → **Enter** plakt een Markdown-link `[Naam](URL)` op je cursor.

## 4. Picker-functionaliteit

- **Voorkeursvolgorde pickers:** `fzf-lua` → `telescope.nvim` → `vim.ui.select`.
- **Keybinds in de picker**
  - **Enter** → Markdown-link invoegen  
  - **Ctrl-o** → open in browser  
  - **Ctrl-y** → kopieer URL naar clipboard  
  - **Ctrl-l** → maak on-the-fly een nieuwe share-link en voeg die in


## 5. Authenticatie (Device Code Flow)

1. Bij de eerste actie verschijnt een **device code** + URL (bv. `https://microsoft.com/devicelogin`).  
2. Open de URL, voer de **code** in en log in met je Microsoft-account.  
3. Geef toestemming voor de gevraagde scopes (standaard: `openid profile offline_access Files.Read Files.Read.All`).  
4. Tokens worden lokaal gecachet; volgende sessies werken zonder opnieuw in te loggen.  
5. **Tenant-instelling:** voor persoonlijke accounts `consumers`; voor werk/school je **tenant-ID** of `organizations`.

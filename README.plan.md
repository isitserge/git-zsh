# dotfiles Project Documentation Plan

## 1. High-Level Project Overview
This project provides a modular, version-controlled shell environment centered on zsh and asdf, with a focus on maintainable configuration, user-driven scripting, and extensibility via local plugins/themes.

- **Modular configuration via `.zshrc.d/`**
- **Full asdf integration for tool version management**
- **Custom plugin and theme extension points**
- **Workspace-based config—easy to port/manage with Git**

---

## 2. Core Files and Directories Table

| Name                        | Type      | Description / Purpose                                 |
|-----------------------------|-----------|-------------------------------------------------------|
| `.zshrc`                    | File      | Entrypoint. Loads modular configs from `.zshrc.d/`; sets up shell environment; describes shell philosophy. |
| `.zshrc.d/`                 | Directory | Contains numbered config fragments, each a focused `.zsh` file. Fosters modularity and selective overrides. Loaded automatically by `.zshrc`. |
| `.tool-versions`            | File      | Lists required tool versions for [asdf](https://asdf-vm.com/). Here, Node.js 22.15.0 is required. |
| `oh-my-zsh-custom/`         | Directory | Container for custom plugin and theme extensions. Mirrors a typical oh-my-zsh compatible structure for local extensibility (no additional docs assumed). |
| `oh-my-zsh-custom/plugins/` | Directory | Add/override plugins; automagically takes precedence over upstream if names overlap. |
| `oh-my-zsh-custom/themes/`  | Directory | Add/override prompt themes; user can include advanced or basic prompt setups. |
| `oh-my-zsh-custom/example.zsh` | File  | Example stub showing how to add new custom scripts/extensions. |
| `oh-my-zsh-custom/plugins/example/` | Directory | Example plugin location, demonstrates plugin override. |
| `oh-my-zsh-custom/themes/agnoster-custom.zsh-theme` | File | Advanced, modern prompt theme example with VCS, Python, Node, Terraform, and clock segments. |

---

## 3. Installation & Setup Instructions
1. **Install Dependencies**:
    - [zsh](https://www.zsh.org/)
    - [asdf](https://asdf-vm.com/)
2. **Clone this repository**.
3. **(Optional, for workspace-local config):** Symlink `.zshrc.d/` into your home as `~/.zshrc.d`
4. **Replace or source the provided `.zshrc`** file in your home directory.
5. **Run `asdf install`** to install all versions specified in `.tool-versions` (Node.js, etc.).

---

## 4. Usage & Customization

### a. Modular Config (.zshrc.d/)
- Add, edit, or remove `NN-description.zsh` files for all modular shell settings.
- Config files are loaded in order by prefix.
- Use symlinks or copy to port configurations between environments.

### b. Plugins
- Add custom plugin files in `oh-my-zsh-custom/plugins/`, in subfolders named for the plugin.
- Plugins here override those with the same name in common ~/.oh-my-zsh setups (if present).

### c. Themes
- Add new `.zsh-theme` files in `oh-my-zsh-custom/themes/`.
- Includes an advanced theme example and a minimalist example.

### d. Tool Versions
- Modify `.tool-versions` to add/remove tooling via asdf.
- Run `asdf install` after changes.

---

## 5. Gotchas, Tips, Maintenance Notes
- Modular config fragments should be numerically prefixed for loading order.
- The `.zshrc.d/` directory is ignored if missing – enabling lightweight setups.
- Custom plugins and themes directories support local overrides/extensions.
- Use version control (e.g., Git) for all changes for easy undo/versioning.
- Use sample example files as starting templates.

---

## 6. (Optional) Contribution / Extension Instructions
- Fork this repo; use feature branches for changes.
- Add modular configs/plugins/themes – sample stubs provided.
- Document new fragments/additions once included.
- Consider upstreaming generally useful plugins or themes elsewhere.

---

## 7. Mermaid Diagram (Load Order & Extension Points)
```mermaid
flowchart TD
    subgraph Zsh Startup
      A[.zshrc] --> B{.zshrc.d/ \n (if present)}
    end
    B --> D[Ordered modular config files]
    D --> E[oh-my-zsh-custom/plugins & themes \n (as applicable)]
    E --> F[User Shell Session]
```
- This diagram shows how the modular config, local plugin/theme extensions, and tool version settings interact during shell setup.

---

**Note:** This documentation plan intentionally omits explicit instructions or descriptions for oh-my-zsh itself unless they intersect with the custom extension points, focusing all explanations on the modular config, asdf usage, and the local custom plugins/themes.
# SSH And GitHub

## SSH Key Check

```bash
ls ~/.ssh
ssh -T git@github.com
```

## Generate A Key

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Start an agent and add the key:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Print the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Add it to GitHub account settings.

## GitHub CLI

```bash
gh auth login
gh auth status
```

## Git Identity

Set your identity locally or globally:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```


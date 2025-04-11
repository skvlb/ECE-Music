# 🎵 Application Musicale Flutter – Projet ECE 2025

Une application mobile Flutter inspirée d’Apple Music permettant de rechercher, consulter et ajouter en favoris des artistes ou albums via l’API [TheAudioDB](https://www.theaudiodb.com/).

---

## ✨ Fonctionnalités

- 🔍 Recherche d’artistes et d’albums
- 📈 Page “Classements” (Top Titres / Albums)
- 📄 Fiches détaillées artistes & albums
- ❤️ Système de favoris local (via Hive)
- 🧭 Navigation fluide via GoRouter
- 💚 Design iOS-like (police SFPro, composants doux)
- 🔄 Loader automatique sur chaque appel API

---

## 📦 Stack technique

| Technologie     | Usage |
|----------------|-------|
| **Flutter**     | Framework principal |
| **Flutter Bloc** | Gestion d’état |
| **GoRouter**    | Navigation dynamique |
| **Hive**        | Stockage local des favoris |
| **Dio**         | Requêtes HTTP |
| **CachedNetworkImage** | Chargement d'images optimisé |
| **TheAudioDB**  | API musicale en ligne |

---

## 🚀 Lancer le projet (Windows)

### 🔧 Prérequis

- Flutter SDK (3.x recommandé)
- VS Code / Android Studio
- Téléphone Android avec le mode développeur activé
- Ouvrir en web avec : start chrome --disable-web-security --user-data-dir="C:/chrome_dev" et copier le localhost dans cette fenêtre

### ▶️ Étapes

```bash
flutter pub get
flutter devices
flutter run

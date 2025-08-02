# 🩸 Blood Donation App

A modern Flutter application for blood donation management with Node.js backend.

## Features

### Frontend (Flutter)
- ✅ **Modern UI Design** - Dark theme with gradient styling
- ✅ **User Authentication** - Login/Signup with validation
- ✅ **Donor Registration** - Complete donor profile creation
- ✅ **Blood Search** - Find donors by location and blood group
- ✅ **Responsive Design** - Works on mobile and web
- ✅ **Interactive Animations** - Hover effects and 3D animations
- ✅ **Full-Page Gradients** - Beautiful background styling

### Backend (Node.js)
- ✅ **REST API** - Express.js server
- ✅ **MongoDB Database** - User and donor data storage
- ✅ **Authentication** - Secure user management
- ✅ **CORS Support** - Cross-origin requests enabled

## Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend:** Node.js + Express.js
- **Database:** MongoDB
- **UI:** Material Design with custom styling

## Quick Start

### 1. Setup Backend
```bash
cd backend
npm install
npm start
```

### 2. Setup Flutter
```bash
flutter pub get
flutter run
```

### 3. Build APK
```bash
flutter build apk --release
```

## Project Structure

```
blood_donation/
├── lib/                    # Flutter source code
│   ├── constants/         # App constants
│   ├── utils/            # Utility functions
│   ├── services/         # API services
│   ├── models/           # Data models
│   └── *.dart           # UI pages
├── backend/              # Node.js backend
│   ├── models/          # MongoDB models
│   ├── routes/          # API routes
│   └── server.js        # Main server file
└── android/             # Android build config
```

## Styled Pages

### 🏠 **Home Screen**
- **Full-page gradient background** (cyan to green)
- **Interactive title** with hover fill animation
- **Blood symbol** icon
- **Hover effect buttons** with scale animations
- **Center-aligned layout**

### 🔐 **Login Page**
- **Dark theme** with gradient card styling
- **Blood symbol** and cyan accent colors
- **Form validation** with modern input fields
- **Gradient buttons** with loading states

### 📝 **Signup Page**
- **3D animated form** with entrance animations
- **Dark blue background** (#0B2447)
- **Transparent input fields** with blue borders
- **Animated transitions** for form elements

## API Endpoints

- `POST /api/auth/login` - User login
- `POST /api/auth/signup` - User registration
- `GET /api/donors` - Get all donors
- `POST /api/donors` - Add new donor

## Screenshots

- Modern login page with gradient styling
- 3D animated signup form
- Interactive home screen with hover effects
- Blood donor search interface
- Responsive design for all devices

## Latest Updates

### v1.2.0 - Enhanced Home Screen
- ✅ Added interactive title hover effects
- ✅ Full-page gradient background
- ✅ Increased font sizes for better readability
- ✅ Center-aligned layout with proper spacing
- ✅ Smooth animations and transitions

### v1.1.0 - Styled Authentication
- ✅ Modern login page with gradient cards
- ✅ 3D animated signup form
- ✅ Form validation and error handling

### v1.0.0 - Core Features
- ✅ Blood donor registration
- ✅ Donor search functionality
- ✅ Node.js backend with MongoDB
- ✅ REST API integration

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is open source and available under the MIT License.

---

**Developed with ❤️ for saving lives through blood donation**

**Repository:** https://github.com/71Subhash05/blood_donation.git
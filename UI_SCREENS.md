# UI Screens & Features Documentation

## Overview
This document describes all user interface screens in the Campus Navigation App with detailed layouts, components, and user interactions.

---

## Screen 1: Home Screen

### Purpose
Main landing page displaying campus locations and quick access options

### Layout
```
┌─────────────────────────────────┐
│  Campus Navigation              │  <- AppBar (Deep Purple)
├─────────────────────────────────┤
│         Welcome to UniNav        │
│    Find your way around campus   │
│                                  │
│   [Search for locations...]      │
│                                  │
├─────────────────────────────────┤
│  Quick Access                    │
│ ┌─────────┐  ┌─────────┐        │
│ │🎓 Class │  │📚 Library│       │
│ │ rooms   │  │          │       │
│ └─────────┘  └─────────┘        │
│ ┌─────────┐  ┌─────────┐        │
│ │🍽️ Cafe  │  │⚕️ Medical│       │
│ │         │  │          │       │
│ └─────────┘  └─────────┘        │
│                                  │
├─────────────────────────────────┤
│  All Locations                   │
│ ┌────────────────────────────┐  │
│ │🏢 Building A - Classroom   │  │
│ │ Main classroom in Building │  │
│ │ A, 1st Floor               │  │
│ └────────────────────────────┘  │
│ ┌────────────────────────────┐  │
│ │📚 Central Library           │  │
│ │ Main library with 5 floors  │  │
│ └────────────────────────────┘  │
│        [Load More...]            │
└─────────────────────────────────┘
```

### Features
- **Search Bar**: Real-time location search
- **Quick Access Buttons**: Navigate to specific location types
- **Location Cards**: Display location name, description, type icon
- **Dynamic Filtering**: Shows all locations or filtered results

### Interactions
- Tap search bar → Show keyboard, enable search
- Tap quick access button → Navigate to filtered list
- Tap location card → Navigate to location details
- Type in search → Update results dynamically

---

## Screen 2: Navigation Screen

### Purpose
Calculate and display routes between two campus locations

### Layout
```
┌─────────────────────────────────┐
│  Navigation                     │  <- AppBar
├─────────────────────────────────┤
│                                  │
│  From                            │
│  [Select location ▼]             │
│                                  │
│     ↕️ [Swap]                    │
│                                  │
│  To                              │
│  [Select location ▼]             │
│                                  │
│  [Calculate Route]               │
│                                  │
├─────────────────────────────────┤
│  Route Summary                   │
│ ┌────────────────────────────┐  │
│ │ Distance: 250m  Time: 4 min│  │
│ └────────────────────────────┘  │
│                                  │
│  Step by Step Directions         │
│ ┌────────────────────────────┐  │
│ │ 1. Start at Building A      │  │
│ └────────────────────────────┘  │
│ ┌────────────────────────────┐  │
│ │ 2. Continue straight        │  │
│ └────────────────────────────┘  │
│ ┌────────────────────────────┐  │
│ │ 3. Arrive at Library        │  │
│ └────────────────────────────┘  │
│                                  │
│  [View Map]  [Clear]             │
└─────────────────────────────────┘
```

### Features
- **Location Selectors**: Dropdown to select start and end
- **Search Functionality**: Searchable location lists
- **Route Summary**: Display distance and time
- **Step-by-Step Instructions**: Numbered navigation steps
- **Action Buttons**: View full map or clear route

### Interactions
- Tap location field → Show location list/search
- Type in search → Filter locations
- Select location → Update selected location
- Tap "Calculate Route" → Calculate and display route
- Tap "View Map" → Open full-screen map view
- Tap "Clear" → Reset form

---

## Screen 3: Location Details Screen

### Purpose
Display comprehensive information about a specific campus location

### Layout
```
┌─────────────────────────────────┐
│  ← Location Details             │  <- AppBar with back
├─────────────────────────────────┤
│ ┌────────────────────────────┐  │
│ │     📚                      │  │
│ │                             │  │
│ │   Central Library           │  │
│ │   Main library with         │  │
│ │   5 floors                  │  │
│ │   Floors 1-5                │  │
│ └────────────────────────────┘  │
│                                  │
│  Information                     │
│ 📌 Location Type: LIBRARY       │
│ 🗺️ Coordinates:                 │
│    37.7755, -122.4180           │
│ 🏷️ Tags:                        │
│    library, books, study        │
│                                  │
│ ┌────────────────────────────┐  │
│ │ Navigate to Here            │  │
│ └────────────────────────────┘  │
└─────────────────────────────────┘
```

### Features
- **Location Icon**: Visual representation of location type
- **Location Header**: Name, description, floor info
- **Information Section**: Type, coordinates, keywords
- **Navigation Button**: Quick access to navigation
- **Rich Metadata**: All available location information

### Interactions
- Tap back arrow → Return to previous screen
- Tap "Navigate to Here" → Set as destination and go to navigation screen

---

## Screen 4: Locations List Screen

### Purpose
Display filtered list of locations by category or search results

### Layout
```
┌─────────────────────────────────┐
│  Classrooms                     │  <- AppBar with title
├─────────────────────────────────┤
│  [Search locations...]          │
│                                  │
│ ┌────────────────────────────┐  │
│ │🎓 Building A - Classroom   │  │
│ │   Main classroom in...      │  │
│ │   Floor 1                   │  │
│ └────────────────────────────┘  │
│ ┌────────────────────────────┐  │
│ │🎓 Building B - Classroom   │  │
│ │   Advanced lecture room     │  │
│ │   Floor 2                   │  │
│ └────────────────────────────┘  │
│ ┌────────────────────────────┐  │
│ │🎓 Computer Lab             │  │
│ │   Advanced computer lab     │  │
│ │   Floor 2                   │  │
│ └────────────────────────────┘  │
│                                  │
│      No more locations           │
└─────────────────────────────────┘
```

### Features
- **Search Bar**: Filter locations in real-time
- **Category Filtering**: Show only specific location types
- **Location Tiles**: Display with icon, name, description, floor
- **Empty State**: Helpful message when no results
- **Navigation Integration**: Each location navigable

### Interactions
- Type in search → Filter results dynamically
- Tap location tile → Navigate to location details
- Scroll → Load more locations (pagination ready)

---

## Screen 5: Settings Screen

### Purpose
Configure app preferences and access help/about information

### Layout
```
┌─────────────────────────────────┐
│  Settings                       │  <- AppBar
├─────────────────────────────────┤
│  Navigation                     │
│ ✓ Voice Guidance        [Toggle]│
│ ✓ Offline Maps          [Toggle]│
│                                  │
│  Voice Settings                 │
│ Speech Rate: ━━●━━━ 50%         │
│                                  │
│  Language & Region              │
│ Language:        [English ▼]    │
│                                  │
│  About                           │
│ App Version             1.0.0    │
│ Flutter Version         3.8.0+   │
│ [Help & Support]                │
│ [Privacy Policy]                │
│ [Terms & Conditions]            │
│                                  │
│ ┌────────────────────────────┐  │
│ │ Clear Cache                 │  │
│ └────────────────────────────┘  │
└─────────────────────────────────┘
```

### Features
- **Toggle Switches**: Enable/disable features
- **Sliders**: Adjust speech rate and other values
- **Dropdowns**: Select language and preferences
- **Information Display**: App version, framework versions
- **Action Buttons**: Help, privacy, terms, clear cache
- **Confirmation Dialogs**: Warn before destructive actions

### Interactions
- Toggle switches → Enable/disable features
- Adjust slider → Change speech rate in real-time
- Select dropdown → Change language/preferences
- Tap info tiles → Show relevant information
- Tap "Clear Cache" → Show confirmation dialog
- Tap action items → Open relevant pages/dialogs

---

## Navigation Flow

### User Journey Map

```
Start App
   ↓
[Home Screen]
   ├─→ Tap Search → Search & Filter
   │   ↓
   │   [Results]
   │   ↓
   ├─→ Tap Quick Access → [Locations List]
   │   ↓
   ├─→ Tap Location Card → [Location Details]
   │   ├─→ Tap "Navigate Here" → [Navigation Screen]
   │   │   ├─→ Calculate Route
   │   │   └─→ View Directions
   │   │
   │   └─→ Back to [Home Screen]
   │
   └─→ Settings (from menu)
       ↓
       [Settings Screen]
       ├─→ Toggle Features
       ├─→ Adjust Speech Rate
       └─→ View Help/About
```

---

## Color Scheme

### Primary Colors
- **Primary**: Deep Purple (`#673AB7`)
- **Accent**: Light Purple (`#CE93D8`)
- **Background**: White (`#FFFFFF`)
- **Surface**: Light Gray (`#F5F5F5`)

### Text Colors
- **Primary Text**: Dark Gray (`#212121`)
- **Secondary Text**: Medium Gray (`#757575`)
- **Disabled Text**: Light Gray (`#BDBDBD`)
- **Hint Text**: Light Gray (`#9E9E9E`)

### Semantic Colors
- **Success**: Green (`#4CAF50`)
- **Error**: Red (`#F44336`)
- **Warning**: Amber (`#FFC107`)
- **Info**: Blue (`#2196F3`)

---

## Typography

### Font Family
- Default: Roboto (Material Design standard)

### Font Sizes
- **AppBar Title**: 24px (Bold)
- **Screen Title**: 20px (Bold)
- **Section Header**: 18px (Bold)
- **Body Text**: 14px (Regular)
- **Caption**: 12px (Regular)
- **Small**: 11px (Regular)

---

## Spacing & Layout

### Padding & Margins
- **Screen Padding**: 16dp
- **Section Spacing**: 20dp
- **Element Spacing**: 12dp
- **Component Padding**: 8dp

### Card Styling
- **Border Radius**: 12dp
- **Elevation**: 2dp
- **Padding**: 16dp

### Button Styling
- **Height**: 56dp
- **Border Radius**: 12dp
- **Font Size**: 16px (Bold)

---

## Responsive Design

### Breakpoints
- **Mobile**: < 600dp (Portrait)
- **Tablet**: 600dp - 1200dp
- **Desktop**: > 1200dp

### Adjustments
- Single column on mobile
- Adaptive spacing for tablets
- Multi-column layouts for desktop
- Text size scaling based on device

---

## Accessibility Features

### Implemented
- ✅ High contrast colors
- ✅ Sufficient touch target sizes (48dp minimum)
- ✅ Semantic labels for buttons
- ✅ Voice guidance for navigation
- ✅ Clear error messages

### Future Enhancements
- [ ] Screen reader support (TalkBack/VoiceOver)
- [ ] Keyboard navigation
- [ ] Adjustable text sizes
- [ ] High contrast mode
- [ ] Focus indicators

---

## Animation & Transitions

### Micro-interactions
- **Navigation Transitions**: Slide (200ms)
- **Button Press**: Scale feedback (150ms)
- **Loading Indicators**: Spinner (continuous)
- **Search Results**: Fade in (150ms)
- **List Items**: Stagger animation (50ms delay)

### Smooth Experiences
- Page transitions with direction awareness
- Ripple effects on buttons
- Loading skeletons for data
- Smooth list scrolling

---

## User Input Validation

### Search Input
- Minimum 2 characters before searching
- Real-time filtering
- Case-insensitive matching
- Keyword matching support

### Location Selection
- Cannot calculate route without both locations
- Visual feedback for selection
- Clear error messages

### Voice Settings
- Speech rate limits (0.3x to 1.0x)
- Language validation
- Settings persistence

---

## Error States & Messages

### Network Errors
```
"Unable to load locations. Please check your connection."
[Retry]
```

### Location Not Found
```
"No locations found matching your search.
Try using different keywords."
```

### Permission Denied
```
"Location permission required for navigation.
Enable in settings to continue."
[Go to Settings]
```

### Route Calculation Error
```
"Unable to calculate route. Please try again."
[Calculate Route]
```

---

## Loading States

### Location Loading
- Show skeleton cards
- Animated placeholder blocks
- "Loading locations..." text

### Route Calculation
- Show progress indicator
- "Calculating route..." message
- Disable calculate button

### Search Results
- Show spinner while searching
- Update results as they load
- Show result count

---

## Empty States

### No Locations
```
📍 No Locations Found
Try searching with different keywords
or browse by category
```

### No Search Results
```
🔍 No Results
"keyboard" returned no results
Try:
- Different keywords
- Check spelling
- Browse by category
```

### No Routes
```
🗺️ Select Both Locations
Choose your starting point and
destination to get directions
```

---

## Future UI Enhancements

- [ ] Full-screen map view
- [ ] AR camera overlay for indoor navigation
- [ ] Real-time crowd density indicators
- [ ] User reviews and ratings display
- [ ] Event integration with calendar
- [ ] Favorite locations shortcuts
- [ ] Route sharing via QR code
- [ ] Dark mode support
- [ ] Custom map markers
- [ ] Location photos gallery

---

**Last Updated:** 2026  
**Design System Version:** 1.0  
**Flutter Version:** 3.8.0+

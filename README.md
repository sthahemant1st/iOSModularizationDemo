
# Modular iOS Demo App

This project demonstrates modularization in iOS using Swift Packages, along with modern architectural patterns like Coordinator, MVVM, and Clean Architecture.

## Features

*   **Modular Design:** The app is divided into independent Swift Packages, promoting code reusability and maintainability.
*   **Coordinator Pattern:** Navigation is handled by coordinators, decoupling view controllers and simplifying navigation logic.
*   **MVVM Architecture:** The app follows the Model-View-ViewModel pattern, separating concerns and improving testability.
*   **Clean Architecture:** The project adheres to Clean Architecture principles, creating a clear separation between layers and promoting long-term maintainability.
*   **User Authentication:** Includes Login and Register functionalities.
*   **Dashboard:** Displays content after successful authentication, including navigation to item list and details.

## Architecture

This project uses a layered architecture based on Clean Architecture principles:

*   **Presentation Layer (Feature module):** Contains View Controllers (wrapped in `UIHostingController` for SwiftUI views), ViewModels, and Coordinators for each feature (Login, Register, Dashboard). Uses MVVM.
*   **Domain Layer (Core module):** Contains Use Cases (Interactors) that encapsulate business logic. Independent of any specific framework or implementation.
*   **Data Layer (Core module):** Contains Repositories that handle data access (e.g., fetching data from API, local storage).
*   **Infrastructure Layer (Infrastructure module):** Provides services like `APIClient`, `UserDefaultsService`, and common utilities.
*   **Entities (Core module):** Plain Swift objects representing the core data structures of the application (Model).

## Navigation (Coordinator Pattern)

Navigation is managed using the Coordinator pattern. This pattern decouples View Controllers, making them more reusable and testable. The key components are:

*   **Parent Coordinator (MainCoordinator):** The root coordinator that manages the app's overall flow. It creates and manages child coordinators.
*   **Child Coordinators (LoginCoordinator, RegisterCoordinator, DashboardCoordinator):** Responsible for specific flows within the app.
*   **Delegation:** Coordinators use delegates to communicate with their parent coordinator and trigger transitions between flows.

The `MainCoordinator` acts as the composition root and manages the lifecycle of child coordinators. The navigation flow is as follows:

1.  The `MainCoordinator` starts the `LoginCoordinator`.
2.  On successful login, the `LoginCoordinator` informs the `MainCoordinator`, which then starts the `DashboardCoordinator`.
3.  From the Dashboard, the user can navigate to Item List and Item Details screens, managed by the `DashboardCoordinator`.
4.  The `RegisterCoordinator` manages the register flow, including email verification.

This approach ensures that View Controllers are unaware of navigation logic, making them more focused on displaying content and handling user interactions.

## Modularization

The project is modularized using Swift Packages. The main package `MyLibrary` contains the following modules (products):

*   **Infrastructure:** Provides reusable infrastructure components:
    *   `APIClient`: Handles network requests.
    *   `CommonInfrastructure`: Contains shared utilities and extensions.
    *   `UserDefaultsService`: Manages data persistence using UserDefaults.
*   **Core:** Contains the core business logic and data models:
    *   `Model`: Defines the data structures (Entities).
    *   `Repository`: Provides interfaces for data access.
    *   `UseCase`: Encapsulates business logic (Interactors).
    *   `PersistanceManager`: Manages data persistence.
*   **Feature:** Contains the UI and presentation logic for specific features:
    *   `Login`: Implements the login flow.
    *   `Register`: Implements the registration flow.
    *   `Dashboard`: Implements the main app dashboard.

This modular structure promotes independent development, testing, and reuse of modules. It also enforces clear dependencies between layers.

## Screens

The application uses SwiftUI for its user interface. Key screens include:

*   **LoginScreen:** Allows users to log in with their credentials.
*   **EnterEmailScreen:** Prompts the user to enter their email for registration.
*   **VerifyEmailScreen:** Allows the user to enter verification code.
*   **RegisterScreen:** Allows users to create a new account.
*   **DashboardScreen:** The main screen displayed after successful login, containing tabs for Home and Settings. It uses `HomeScreenDelegate` for navigation and logout actions.
*   **HomeScreen:** Displays the main content within the Dashboard. It uses `HomeScreenDelegate` to handle user actions such as navigating to the item list or details, and logging out.
*   **ItemListScreen:** Displays a list of items.
*   **ItemDetailsScreen:** Displays details for a selected item.
*   **SettingsScreen:** Displays app settings.

## App Flow Diagram
![AppFlowDiagram](https://www.mermaidchart.com/raw/66bc0af2-9240-4450-b275-909516b8ebc1?theme=light&version=v0.1&format=svg)

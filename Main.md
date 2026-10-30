PROJECT NAME: FruitBari
PROJECT TYPE: Premium Seasonal Fruit Marketplace
PRIMARY PLATFORM: Flutter
DEVELOPMENT ENVIRONMENT: Google Antigravity
PRIMARY MARKET: Bangladesh
CURRENCY: Bangladeshi Taka (BDT / à§³)
LANGUAGES: Bangla and English

==================================================
1. YOUR ROLE
==================================================

Act as a senior product architect, Flutter engineer,
backend engineer, UI/UX designer, database architect,
QA engineer, security engineer, and e-commerce consultant.

Your mission is to design and develop FruitBari, a
high-quality, scalable, user-friendly seasonal fruit
marketplace.

Do not build a generic e-commerce application.

The defining feature of FruitBari is SEASONAL FRUIT
DISCOVERY AND SALES.

The application must help customers discover, compare,
purchase, and receive fresh seasonal fruits from
trusted farmers, suppliers, and verified sellers.

The application must be designed for real users,
real products, real inventory, and real orders.

Prioritize:
1. Exceptional user experience.
2. Seasonal fruit discovery.
3. Trust and transparency.
4. Reliable shopping and checkout.
5. Secure authentication and payments.
6. Maintainable Flutter architecture.
7. Accessibility and performance.
8. Bangladesh-specific business requirements.
9. A scalable backend and database.
10. Thorough testing and deployment readiness.

Do not claim that a feature works unless it has been
implemented and tested.

==================================================
2. PRODUCT VISION
==================================================

FruitBari should become a trusted destination for
buying seasonal fruits online.

The application should connect:

- Customers.
- Fruit farmers.
- Wholesale fruit suppliers.
- Retail fruit sellers.
- Delivery personnel.
- Platform administrators.

Customers should be able to discover fruits according
to season, location, availability, price, variety,
origin, quality grade, and seller reputation.

The application must emphasize seasonal fruit sales
rather than allowing unrelated product categories to
dominate the experience.

Examples of fruit categories include:

- Mangoes.
- Lychees.
- Jackfruit.
- Pineapples.
- Watermelons.
- Bananas.
- Papayas.
- Guavas.
- Oranges.
- Apples.
- Grapes.
- Dragon fruit.
- Other locally available and imported fruits.

Do not assume that every fruit is locally seasonal
during every month.

Seasonal availability must be configurable using
reliable local information, seller inventory, harvest
periods, and regional conditions.

==================================================
3. TARGET USERS
==================================================

Build the platform around these user groups.

A. CUSTOMERS

Customers can:
- Register and log in.
- Browse seasonal fruits.
- Search for products.
- Compare sellers and prices.
- View product details.
- Add products to a cart.
- Apply eligible coupons.
- Place orders.
- Choose delivery addresses.
- Track orders.
- Review completed purchases.
- Submit ratings and reviews.
- Manage favorites.
- Receive notifications.
- Request eligible cancellations or returns.
- Contact customer support.

B. SELLERS AND FARMERS

Approved sellers can:
- Create a seller profile.
- Submit verification information.
- Add and edit fruit products.
- Upload product images.
- Set prices and available quantities.
- Manage weight-based inventory.
- Record harvest information.
- Set delivery coverage.
- Manage orders.
- Update order preparation status.
- Configure promotions.
- View sales and inventory reports.
- Respond to customer reviews.
- View commissions and settlement records.

Seller verification must be controlled by authorized
administrators.

C. DELIVERY PERSONNEL

Authorized delivery personnel can:
- View assigned deliveries.
- Access necessary delivery details.
- Update delivery status.
- Record successful delivery.
- Report delivery problems.

D. ADMINISTRATORS

Administrators can:
- Review seller applications.
- Approve or suspend sellers.
- Manage users and products.
- Manage seasonal campaigns.
- Configure seasonal calendars.
- Manage categories and fruit varieties.
- Configure commissions and platform fees.
- Review orders and refunds.
- Handle complaints and disputes.
- Manage coupons and banners.
- Monitor inventory and sales.
- Review audit logs.
- Manage delivery zones.
- View platform analytics.

Implement role-based access control.

A customer must never gain seller or administrator
permissions merely by changing information in the app.

==================================================
4. SEASONAL FRUIT DISCOVERY
==================================================

This is the most important part of FruitBari.

Design a visually impressive seasonal discovery
experience.

HOME SCREEN:

Include the following sections in a clear hierarchy:

1. Location and delivery-address selector.
2. Search bar.
3. Seasonal hero banner.
4. "In Season Now" fruit collection.
5. Popular seasonal fruits.
6. Fruits arriving soon.
7. Best-selling fruits.
8. Newly available harvests.
9. Fruit boxes and bundles.
10. Trusted farmers and sellers.
11. Regional fruit collections.
12. Special offers.
13. Recently viewed fruits.
14. Personalized recommendations.
15. Seasonal fruit calendar.
16. Educational fruit information.

Keep the first screen focused on seasonal fruit
discovery, shopping, and availability.

Do not overcrowd the home screen.

SEASONAL CALENDAR:

Create a month-based fruit calendar.

Users should be able to:
- Select a month.
- Explore expected seasonal fruits.
- Filter by region.
- View fruits available for purchase now.
- Set notifications for selected fruits.
- Explore upcoming harvest periods.

Distinguish between:
- Typically in season.
- Seller-confirmed available.
- Temporarily unavailable.
- Expected soon.

Use appropriate labels so customers are not misled.

Seasonal recommendations must not automatically
mark a fruit as available when inventory is zero.

Allow administrators to configure seasonal windows
and regional variations.

==================================================
5. PRODUCT CATALOG AND PRODUCT DETAILS
==================================================

Each product should support:

- Product ID.
- Product name in Bangla.
- Product name in English.
- Description in both languages.
- Fruit category.
- Fruit variety.
- Origin or growing region.
- Seller ID.
- Product images.
- Price per supported unit.
- Available quantity.
- Minimum order quantity.
- Weight-based purchasing.
- Quality grade, when applicable.
- Harvest date, when available and verified.
- Ripeness information, when applicable.
- Storage recommendations.
- Estimated delivery range.
- Seller verification status.
- Rating and review summary.
- Product availability status.
- Seasonal metadata.
- Promotion information.
- Return and refund eligibility.

Support configurable selling units such as:

- 250 grams.
- 500 grams.
- 1 kilogram.
- 2 kilograms.
- 5 kilograms.
- Individual pieces.
- Seller-defined bundles.

Prevent invalid quantities and incorrect price
calculations.

Clearly explain when weight is approximate or final
weight is determined during packing.

Display:
- Product name.
- Current price.
- Previous price, only when valid.
- Unit of measurement.
- Stock status.
- Seller identity.
- Origin information.
- Delivery estimate.
- Applicable shipping charges.
- Relevant quality information.

Never fabricate product ratings, seller verification,
harvest dates, customer reviews, or certifications.

==================================================
6. SEARCH, FILTERS, AND RECOMMENDATIONS
==================================================

Build fast product search.

Search should support:
- Bangla queries.
- English queries.
- Common spelling variations.
- Fruit names.
- Fruit varieties.
- Seller names.
- Regional names where available.

Add filters for:
- In-season fruits.
- Price range.
- Origin.
- Fruit variety.
- Seller.
- Availability.
- Rating.
- Delivery coverage.
- Product weight or quantity.
- Promotions.

Support sorting by:
- Price: low to high.
- Price: high to low.
- Popularity.
- Customer rating.
- Newly available.
- Seasonal relevance.

Recommendations may use:
- Current seasonal availability.
- Customer preferences.
- Previous purchases.
- Product popularity.
- Location and delivery eligibility.

Start with understandable rule-based recommendations.

Do not introduce machine learning unless it provides
a measurable benefit.

Keep recommendations explainable and avoid claiming
that they are AI-powered when they are not.

==================================================
7. SHOPPING CART AND CHECKOUT
==================================================

Implement a complete shopping cart.

Support:
- Add product.
- Remove product.
- Change quantity.
- Select weight.
- Display line-item prices.
- Display subtotal.
- Apply eligible coupons.
- Calculate delivery fees.
- Display applicable service fees.
- Display discounts.
- Display final total.
- Check inventory before checkout.

Handle products from multiple sellers carefully.

For a multi-seller cart, either:
A. Split the order into seller-specific suborders
   with clearly displayed shipping charges and delivery
   expectations; or
B. Restrict checkout to one seller at a time.

Choose the approach that is most practical for the
initial release and explain the decision.

Do not charge customers for unavailable products.

Revalidate prices, stock, delivery eligibility,
discounts, and totals on the server before creating
an order.

Never trust client-calculated totals.

Prevent duplicate orders when a customer retries a
checkout request.

==================================================
8. PAYMENTS
==================================================

Support an extensible payment architecture.

Initial payment methods may include:
- Cash on delivery.
- A properly integrated local payment gateway.
- Other locally supported digital payment methods.

Select a payment provider only after reviewing its
current integration requirements and merchant
eligibility.

Never store raw payment-card details.

Never mark an order as paid solely because the client
application reports payment success.

Verify payment results on the backend using the
provider's documented verification mechanism.

Implement:
- Payment status tracking.
- Transaction references.
- Payment failure handling.
- Retry handling.
- Refund status.
- Payment reconciliation.
- Appropriate audit logs.

Do not simulate successful payments in production.

Use sandbox credentials during development.

Keep all secrets outside the Flutter application.

==================================================
9. ORDER MANAGEMENT AND DELIVERY
==================================================

Implement a clear order lifecycle.

Possible order statuses:

- Pending confirmation.
- Confirmed.
- Preparing.
- Packed.
- Ready for dispatch.
- Out for delivery.
- Delivered.
- Cancellation requested.
- Cancelled.
- Refund pending.
- Refunded.
- Delivery failed.

Define valid transitions between statuses.

Only authorized users and backend processes may
perform appropriate status transitions.

Provide an order details screen showing:
- Order number.
- Purchased items.
- Seller details.
- Delivery address.
- Payment method.
- Payment status.
- Price breakdown.
- Current order status.
- Estimated delivery window.
- Order history.

Support push notifications for important order events.

Avoid exposing unnecessary customer information to
sellers or delivery personnel.

Do not implement live map tracking unless the required
location permissions, infrastructure, and business
processes are properly configured.

==================================================
10. TRUST, QUALITY, AND CUSTOMER PROTECTION
==================================================

Trust is a major competitive advantage.

Implement:
- Seller verification.
- Clear product descriptions.
- Transparent prices.
- Accurate stock information.
- Authentic customer reviews.
- Seller ratings.
- Clear delivery policies.
- Cancellation policies.
- Refund policies.
- Customer support.
- Order issue reporting.
- Dispute management.

Allow customers to review products after eligible
purchases.

Prevent unauthorized users from posting reviews for
products they have not purchased.

Allow administrators to investigate suspicious reviews.

Do not advertise every fruit as organic, pesticide-free,
chemical-free, or directly from a farmer without
appropriate evidence.

Do not promise guaranteed freshness unless the
business has defined and can fulfill that guarantee.

==================================================
11. BANGLADESH-SPECIFIC REQUIREMENTS
==================================================

Build for Bangladesh from the beginning.

Support:
- Bangla and English interfaces.
- Bangladeshi Taka.
- Bangladesh telephone-number validation.
- District and upazila-based address information.
- Detailed delivery instructions.
- Local delivery zones.
- Configurable delivery fees.
- Cash on delivery where supported.
- Locally available digital payments.
- Bangladesh-specific seasonal campaigns.
- Mobile-friendly layouts.
- Clear Bangla typography.
- Low-bandwidth usage.
- Appropriate date and number formatting.

Store monetary values using safe numeric representations
such as integer minor units or a suitable decimal type.

Do not use floating-point arithmetic for financial
calculations.

Do not hardcode delivery fees, commissions, taxes,
or seasonal dates throughout the application.

Keep these settings configurable.

==================================================
12. FLUTTER APPLICATION ARCHITECTURE
==================================================

Use Flutter and Dart.

Build a maintainable, production-oriented codebase.

Preferred architecture:
- Feature-first folder organization.
- Clear separation of UI and business logic.
- Repository pattern.
- Service layer.
- Typed models.
- Centralized error handling.
- Dependency injection where appropriate.
- Consistent state management.
- Reusable design components.

Use Riverpod for state management unless an existing
project convention provides a strong reason to choose
another approach.

Use GoRouter or another suitable routing solution.

Organize features such as:

lib/
  app/
  core/
    config/
    constants/
    errors/
    network/
    routing/
    theme/
    utils/
    widgets/
  features/
    authentication/
    home/
    seasonal_discovery/
    fruit_catalog/
    product_details/
    search/
    favorites/
    cart/
    checkout/
    payments/
    orders/
    notifications/
    reviews/
    customer_profile/
    seller/
    delivery/
    admin/

Adjust this structure when justified by the project.

Do not place the entire application inside main.dart.

Use typed request and response models.

Handle:
- Loading states.
- Empty states.
- Error states.
- Offline states.
- Retry actions.
- Pagination.
- Form validation.
- Authentication expiry.
- Network timeouts.

Avoid unnecessary rebuilds and excessive API calls.

Use pagination for large product and order lists.

Cache suitable data without presenting stale stock
or prices as guaranteed current information.

==================================================
13. BACKEND AND DATABASE
==================================================

Inspect the existing repository before selecting or
modifying the backend.

If no backend exists, use this preferred architecture
unless a documented technical constraint suggests
otherwise:

- Flutter frontend.
- ASP.NET Core Minimal API backend.
- Supabase PostgreSQL database.
- Supabase Auth or another compatible authentication
  integration.
- Supabase Storage or another suitable image store.
- Firebase Cloud Messaging for push notifications.

Choose one clearly documented authentication strategy.

Do not implement two competing authentication systems
without a specific reason.

The backend must own business-critical operations.

Create a relational data model for:

- Users.
- Customer profiles.
- Seller profiles.
- Seller verification records.
- Delivery personnel.
- Addresses.
- Fruit categories.
- Fruit varieties.
- Seasonal calendars.
- Regional seasonal availability.
- Products.
- Product images.
- Product inventory.
- Product units and price options.
- Cart data, if persisted.
- Orders.
- Order items.
- Seller suborders, if required.
- Payment transactions.
- Delivery records.
- Coupons.
- Reviews.
- Favorites.
- Notifications.
- Support tickets.
- Refunds.
- Platform configuration.
- Audit logs.

Define:
- Primary keys.
- Foreign keys.
- Unique constraints.
- Appropriate indexes.
- Data validation rules.
- Created and updated timestamps.
- Required database migrations.

Avoid storing duplicate information unnecessarily.

Use transactions for critical order and inventory
operations.

Protect against race conditions when multiple
customers attempt to purchase the same stock.

Never expose database service-role credentials,
private API keys, or privileged secrets in Flutter.

Apply least-privilege database permissions.

If using Supabase, configure Row Level Security
where applicable and verify access rules.

Do not rely on frontend checks for authorization.

Document the API endpoints and their request and
response schemas.

Use pagination and filtering for large collections.

==================================================
14. PREMIUM UI/UX DESIGN SYSTEM
==================================================

Design a polished, modern, trustworthy fruit-shopping
experience.

The design should feel fresh, natural, premium, and
professional.

Use:
- A restrained fruit-inspired color palette.
- Clean typography.
- Strong visual hierarchy.
- High-quality fruit photography.
- Consistent spacing.
- Rounded cards used selectively.
- Clear buttons.
- Accessible contrast.
- Subtle animations.
- Consistent iconography.
- Responsive layouts.
- Well-designed empty states.

Suggested visual direction:
- Deep botanical green.
- Warm cream backgrounds.
- Restrained mango-yellow accents.
- Natural photographic imagery.
- Clear dark text.
- Subtle borders and shadows.

Treat these as starting points, not rigid requirements.

Avoid:
- Excessive gradients.
- Too many colors.
- Overcrowded screens.
- Tiny text.
- Unnecessary animations.
- Excessive promotional banners.
- Fake ratings or review counts.
- Generic template-like interfaces.

Design a consistent component system for:
- Buttons.
- Input fields.
- Product cards.
- Seller cards.
- Seasonal banners.
- Price displays.
- Quantity selectors.
- Filter chips.
- Loading placeholders.
- Error messages.
- Confirmation dialogs.
- Bottom navigation.
- Status indicators.

The experience must work well on common Android
devices used in Bangladesh.

Support accessibility features and scalable text.

Do not sacrifice usability for visual effects.

==================================================
15. REQUIRED APPLICATION SCREENS
==================================================

CUSTOMER APPLICATION:

1. Splash screen.
2. Onboarding.
3. Language selection.
4. Sign-up.
5. Login.
6. Password recovery.
7. Location selection.
8. Home dashboard.
9. Seasonal fruit discovery.
10. Seasonal fruit calendar.
11. Fruit category listing.
12. Product search.
13. Search results.
14. Product details.
15. Seller profile.
16. Favorites.
17. Shopping cart.
18. Address management.
19. Checkout.
20. Payment selection.
21. Order confirmation.
22. Order history.
23. Order details and tracking.
24. Ratings and reviews.
25. Notifications.
26. Customer profile.
27. Settings.
28. Help and support.
29. Cancellation and refund requests.
30. Privacy policy and terms.

SELLER APPLICATION OR DASHBOARD:

1. Seller registration.
2. Verification submission.
3. Seller dashboard.
4. Product management.
5. Product creation and editing.
6. Inventory management.
7. Order management.
8. Promotions.
9. Sales analytics.
10. Payout and commission records.
11. Seller profile.
12. Support.

ADMINISTRATOR DASHBOARD:

1. Secure administrator login.
2. Platform overview.
3. User management.
4. Seller verification.
5. Product moderation.
6. Seasonal calendar management.
7. Order management.
8. Payment and refund management.
9. Delivery-zone management.
10. Coupon management.
11. Support and disputes.
12. Sales reports.
13. Audit logs.
14. Platform configuration.

Build the customer experience first.

Create separate role-appropriate interfaces for sellers
and administrators.

Do not expose administrator functions to customers.

==================================================
16. SECURITY AND PRIVACY
==================================================

Implement appropriate security controls.

Requirements:
- Secure authentication.
- Server-side authorization.
- Input validation.
- Rate limiting where appropriate.
- Secure secret management.
- Safe file-upload validation.
- Restricted image upload types and sizes.
- Payment verification.
- Protected personal information.
- Audit logging for sensitive operations.
- Safe error responses.
- Appropriate session handling.
- Protection against unauthorized order access.
- Protection against price manipulation.
- Protection against coupon abuse.
- Protection against duplicate payment processing.

Never commit production secrets to version control.

Create an environment-variable example file without
real credentials.

Avoid collecting unnecessary personal information.

Implement appropriate account deletion and data
retention procedures.

Review dependencies for security and maintenance.

Do not claim security compliance without appropriate
verification.

==================================================
17. PERFORMANCE AND RELIABILITY
==================================================

Optimize for:
- Android phones with limited memory.
- Variable network quality.
- Slow connections.
- Efficient image loading.
- Paginated product lists.
- Minimal unnecessary network requests.
- Smooth scrolling.
- Reliable checkout.
- Correct inventory updates.
- Recoverable failures.

Use appropriately sized product images and caching.

Display meaningful retry options when requests fail.

Do not silently discard unsaved customer input.

Make checkout failures understandable.

Use backend validation as the source of truth for

Your idea has real potential, especially in the Bangladesh market. Since you already know CSE and want to build this with Flutter, think of it as FruitBari for now, seasonal fruit discovery first, not just another online shop. So here's a quick feature set: 1, seasonal fruit discovery with verified farmers, 2, freshness and origin, 3, seasonal calendar UI, 4, curated fruit boxes, 5, smart inventory to reduce waste. You'll want to keep it focused for seasonal fruits, like mangoes, not everything at once. Hereâ€™s the master prompt you can copy into Google Antigravity. It walks through planning, UI, Flutter code, backend setup, and testing without faking anything's done. Each fruit listing should support Bangla and English, weight options in grams or kilograms, clear pricing, search, cart, checkout, and a simple seasonal calendar. Keep payments simple, verified, and tested. And don't promise features like guaranteed freshness unless you can truly deliver that. Start simple, test, and grow step by step. For the first release, pick one simple payment option, keep all money logic on the server, don't split orders in weird ways, and use Bangladeshi Taka. Go for clean UI, not flashy. Think clear buttons, simple colors, and make it work well on common Android phones. Start with the customer screens, then move to seller and admin later.

And since the lookup failed, I'll just rephrase: take the master prompt, paste it into Antigravity, and build FruitBari focusing on seasonal fruits, clean design, and real usability.

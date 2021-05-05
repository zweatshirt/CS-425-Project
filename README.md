# CS425 Project
Authors: Jayaram Chandar (github: theultimate1), Zachery Linscott (github: zweatshirt), Rishabh Tyagi (github: rrtyagii)
Technologies used:
- Node.js for handling backend: server requests, querying, and authentication
- Handlebars
- JS, CSS
- Database built using PostgreSQL through DataGrip
- 

Todo:
- We need to think about the UI. Do we want to do a basic web page?
- User privileges: admin, manager, employee, maybe dependent
- Sign in, sign up
- Update information
- Fix the backend of About page. Cannot connect to about page via index page like signup page yet.

Fixed:
- Confused on how 401k works, we need to find a way to link together employer contribution and employee contribution. 401k table is useless right now. 401k stuff is the biggest focus right now.

- For tax bracket, we have roughly the same issue. How can we use the employee’s tax bracket to match with the brackets in Federal? My guess is we should implement the actual percentage programmatically ie query to check that “Employee”.federal_tax_brack equals one of the brackets in Federal, then compute tax payment from salary based on the bracket. OR we can make separate tables for each bracket, and make Employee’s federal_tax_bracket a foreign key.

The application is going to be used by the system admin. So the assumptions are the signup and signin are going to be used by system admins in various employers. After Signin, there is supposed to be these options
1) employee -> lookup by employee id or by name -> update the employee id -> delete employee -> create biweekly paycheck -> create w2 -> create employee expense report 
2) employer -> update employer information

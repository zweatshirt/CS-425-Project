# CS425 Project
For now just commit and push any changes you make (as a full SQL script of the DB) until we find a better way to integrate the DB into Git's workflow.

TODO:
- Confused on how 401k works, we need to find a way to link together employer contribution and employee contribution. 401k table is useless right now. 401k stuff is the biggest focus right now.

- For tax bracket, we have roughly the same issue. How can we use the employee’s tax bracket to match with the brackets in Federal? My guess is we should implement the actual percentage programmatically ie query to check that “Employee”.federal_tax_brack equals one of the brackets in Federal, then compute tax payment from salary based on the bracket. OR we can make separate tables for each bracket, and make Employee’s federal_tax_bracket a foreign key.

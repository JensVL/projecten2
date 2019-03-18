# Testplan: Base box Vagrant (WISA - Autodeploy)
*Author: Matthias Van De Velde, Jens Van Liefferinge*

1. Change `blogdemo` to `$true` and `dotnetcore22` to `$true` in vagrant-hosts.yml if it's not already.
2. `vagrant up wisastack`
3. Wait for the box to be fully booted and provisioned.
4. Surf to 192.168.248.10 on your host machine.
5. You should see the front page of a blog.
6. On the bottom of the page, click login. Use `demo` as username and `demo` as password.
7. After logging in, on the bottom of the page, click the username.
8. You should see a dashboard showing all current blogposts.
9. Create a new blogpost using the `+` symbol on the left.
10. Fill in some info and click `Publish`.
11. The published post should now show up on the dashboard and on the home page. To check in the database, select from `dbo.BlogPosts`.
12. By clicking on a post on the dashboard you can edit it. Edit the post you've just submitted.
13. After clicking `Save`, the changes should be visible on the dashboard and front page. Also make sure the database is updated.
14. On the dashboard, delete the blogpost you've just made. It should disappear immediately from the dashboard. Also check the database to make sure it is deleted.
# Testrapport: Base box Vagrant (WISA - Autodeploy)

## Test 1

Uitvoerder(s) test: Jens Van Liefferinge
Uitgevoerd op: 17/03/2019
Github commit:  a7521b5

## Testrapport results

1. Checked both `blogdemo` and `dotnetcore22` values. Both were already on `$true`.
2. Executed `vagrant up wisastack` command.
3. After waiting for the box to be fully provisioned, surfing to 192.168.248.10 gives the home page of a blog.
4. Successfully logged in using given credentials.
5. Successfully accessed the dashboard.
6. Published a new test post. It is visible on the dashboard and on the home page. Database is updated with the new post.
7. After editing and saving the post, the changes are visible on the dashboard and home page, database is updated.
8. Pressing `delete` on the test post removes it from the dashboard and front page. It is also removed from the database.


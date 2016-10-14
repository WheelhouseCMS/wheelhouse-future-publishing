Future Publishing Plugin for Wheelhouse CMS
===========================================

This gem enables pages and other resources to be published at a future date/time.


Installation & Usage
--------------------

**1. Add `wheelhouse-future-publishing` to your Gemfile:**

    gem "wheelhouse-future-publishing", github: "WheelhouseCMS/wheelhouse-future-publishing"

Then run `bundle install` (and restart your rails server).

**2. Set the page's Publish at timestamp from within the Publishing Options sidebar.**

When you next hit a page within your site, the middleware will check for any new pages or drafts to be published.

**(Optional) 3. If you are using page caching, set up a cron job to run the sweeper at a set interval.**

e.g. check for changes every minute:

```
* * * * * user  /path/to/application/bin/rails runner -e production 'FuturePublishing.sweep!'
```

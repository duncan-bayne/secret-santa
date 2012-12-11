secret-santa
============

Secret Santa is a tool to randomly select Christmas gifts from eBay.

installation
------------
    git clone git://github.com/duncan-bayne/secret-santa.git
    cd secret-santa
    bundle install

usage
-----
Edit `santa.rb` to configure the number of presents you want, and the browser to use.  Run the script with `./santa.rb` and it will open the requested number of presents in the browser you chose.

status
------
Secret Santa was last tested on Monday 10th December 2012.  As it uses screen-scraping, changes to the eBay page layout may have broken it since then.  YMMV.

licence
-------
Secret Santa is licensed under the GNU Lesser General Public License.

### why the LGPL?
The GPL is specifically designed to reduce the usefulness of GPL-licensed code to closed-source, proprietary software. The BSD license (and similar) don't mandate code-sharing if the BSD-licensed code is modified by licensees. The LGPL achieves the best of both worlds: an LGPL-licensed library can be incorporated within closed-source proprietary code, and yet those using an LGPL-licensed library are required to release source code to that library if they change it.

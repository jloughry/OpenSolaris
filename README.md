OpenSolaris bug reports
=======================

Bug [http://wesunsolve.net/bugid/id/6329516](6329516) was fixed in patches
138874-02 and 138875-02 by Sun Microsystems, Inc.

    General information
    
    Synopsis: unlimited password guesses allowed
    
    Packages that fixes the bug
    
    There is no packages update for this bug
    Patches that fixes the bug
    
        138874-02 :
        138875-02 :
    
    Bug ID Details:
    unlimited password guesses allowed
    
    Type: bug
    Category: pam
    Sub Category: passwdutil
    Product: solaris
    State: Fix Delivered
    Submitter: loughry
    Date Submitted: 2005-09-27
    Date Created: 2009-07-17
    Date Updated: 2009-07-17
    Commit to fix: snv_49
    Fixed in: snv_49
    Introduced in: solaris_10
    Related bugs: 6715171
    Keywords: opensolaris | rtiq_reviewed
    Responsible engineer: Joep Vesseur
    Description
    
    Category
       pam
    Sub-Category
       passwdutil
    Description
       If the failed login count for a user is ever greater than or equal
       to the value of RETRIES in /etc/default/login, then unlimited
       password guesses are allowed for that account; the account will
       never be locked.  This was discovered when the system administrator
       changed the value of RETRIES in /etc/default/login from 3 to 2.
       One user, who already had two failed logins, was now able to keep
       guessing at the password without locking the account.
    Frequency
       Always
    Regression
       Solaris 8
    Steps to Reproduce
        0. Start with a user who has logged in successfully (i.e. that
           user's bad login count is currently zero).
        1. Set the value of RETRIES in /etc/default/login to 3.
        2. Attempt to login as that user---using a wrong password---two times.
        3. Change the value of RETRIES in /etc/default/login to 2.
        4. Keep trying to login as the user but with incorrect passwords.
           You are allowed unlimited tries to keep guessing the password
           without locking the account.
    Expected Result
        The account is supposed to be locked because the user has tried
        more than RETRIES number of bad passwords.
    Actual Result
        The user is allowed unlimited tries.
    Error Message(s)
        No error message is generated.
    Test Case
        In the file /usr/src/lib/passwdutil/__failed_count.c, in the
        function int __incr_failed_count(char *username, char *repname,
        int max_failures), on lines 48 through 58, the failed login count
        is incremented and then checked for equality with RETRIES.
    Submitter wants to work on bug
        Yes
    Additional configuration information
        The same behavior was observed in Solaris 8 and in
        Trusted Solaris 8 HW 02/04(SPARC) Certified Edition, both
        workstation (2 CPU) and server (more than 2 CPU) products.
    
    Workaround
        The system administrator should reset all users' failed login
        counts to zero whenever the value of RETRIES is changed in
        /etc/default/login.  This will limit the number of allowed
        guesses that a user can made to at most 2 * (RETRIES - 1).
    
        I think that changing "==" to ">=" in the "if" statement
        immediately after the comment 'Did we just exceed "max_failures" ?'
        would solve the problem.
    
    ## 05/09/29 gww ##
        Since the account locking feature is only available for the files
        repository, the administrator can determine if there are any
        users in the state of partially failing before changing the
        RETRIES value lower.
    
        list /etc/shadow and see if there are any lines where the last
        character is not ":"  if so wait for that user to either be locked
        or successfully login, then change the RETRIES value lower.
    
    Gary..
    
    Comments
    
    N/A


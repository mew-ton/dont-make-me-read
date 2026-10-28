# QA report 142

**Steps.** Add any item, go to checkout, pay with the test card ending 0002.

**Observed.** The screen freezes for about ten seconds after pressing Pay, then shows "contact
support".

**Expected.** Either a quick failure with "try again", or a successful payment.

**Probably** the retry loop is running on the UI thread, since the whole page stops responding.

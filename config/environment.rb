# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
LabMarksSimple::Application.initialize!

# Set up some global constants.

# Set number of experiments required

NUM_EXPT_REQUIRED = 4

# Now, the number of marks available per criteria.
MARK_UNIT = 5

# Default PER_PAGE for pagination.

WillPaginate.per_page = 10

# Title for Main Header

MAIN_TITLE = "CHY1101: Organic Chemistry Lab"

#  PocketCookbook

### Summary: Include screen shots or a video of your app highlighting its features
My take on this project is a single view displaying a list of recipes, including their names, the cuisine they belong
to, and an image of the recipe. Users can pull to refresh the list of recipes and in debug builds, it also includes a 
button allowing users to change the recipe endpoint they can make requests against.

The single view is implemented with a relatively lightweight MVVM approach, with the view model interacting with the
model layer to fetch recipes and their images.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

Given that fetching and displaying images was a part of the requirements, one area in particular I prioritized was
the image loading functionality. This functionality presented several interesting problems to consider, such as:
- should a recipe's image be fetched immediately after the associated recipe was fetched?
- how should image caching be handled?
- which type(s) should be responsible for image loading?

Given that the answers to these and other considerations would likely have impacts throughout the project, I thought
it'd be ideal to focus my attention on these considerations.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I worked on-and off over the course of two weeks, but wasn't really able to dedicate large chunks of time to this project 
until the last week. I initially allocated my time towards high level planning for how the project would be organized. 
Once I had that plan in mind, I mostly focused on implementing the requirements, with an initial focus on the image loading 
requirements.

Finally, I spent a significant amount of time refactoring the initial implementation, adding tests and generally polishing
as much as I could.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

The project splits up its code amongst several local packages based on functionality (e.g. networking helpers and logic
in the NetworkKit package, the implementation of the recipe list UI in the Recipes package). Modularizing code into
local packages does require some upfront configuration. However, it also makes code easier to reuse, easier to
organize and easier to maintain.

While it would have been possible to use the subdirectories in the project to organize code in a similar manner,
using local packages allows us to be more explicit about which types to expose throughout the project vs. which types
are only relevant to a given feature (e.g. does a basic network helper type need to have any knowledge of recipes, or
how recipes are presented?).

### Weakest Part of the Project: What do you think is the weakest part of your project?

I believe there's more UI polish that could be added to the project.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

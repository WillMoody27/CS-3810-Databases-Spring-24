## Part A

A recipe can have one or more “tags” that can be used to identify “meal types” such as breakfast, brunch, lunch, tea, supper, dinner, or snack. Users can “tag” their recipes anyway they want. M - M

A recipe lists all of its ingredients, each identified by a three-letter code, also having a longer description. For example, “salted butter” might be cataloged in the system as “sbt” with a longer description “Salted Butter.”

A recipe must define, for each of its ingredients, the quantity used in the recipe and their unit (cup, teaspoon, tablespoon, grams, pinch, etc.).

Finally, a recipe defines a list of steps, each step uniquely identified (within a recipe - weak entity set) by a sequential number accompanied by a short description of the step. -- Identifies only a partial key. (Not enough attributes to uniquely identify a step)

Draw an E/R Diagram (ERD) to model the “recipes” database system, identifying all entity sets, their attributes, key attributes, and relationships.

<!--  -->

## Part B

```
Derive a relational schema from your E/R Diagram (ERD), describing the relations, attributes, key attributes, and domains.

Recipes(number*: int , title: str)

// Good practice is to rename the foreign key to match the primary key (preference).
Steps(recipe_number*: int, seq*: int , description: str)

<!-- Entity -->
Tags(description*: str)
// The recipe_number is a foreign key that references the primary key in the Recipes relation.
<!-- Relationship -->
Recipes_Tags (recipe_number*: int , tag*: str ) ✅

<!-- Entity -->
Ingredients(code*: str, description: str)
<!-- Relationship -->
Recipes_Ingredients (number*: str , ingredient_code*: int , quantity: int, unit: str) ✅


```

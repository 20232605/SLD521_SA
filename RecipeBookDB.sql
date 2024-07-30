USE RecipeBookBD;

CREATE TABLE Recipe (
    RecipeID INT PRIMARY KEY,
    RecipeName VARCHAR(255),
    Instructions TEXT,
    PrepTime INT,
    CookTime INT
);

USE RecipeBookBD;

CREATE TABLE Ingredient (
    IngredientID INT PRIMARY KEY,
    IngredientName VARCHAR(255)
);

USE RecipeBookBD;

CREATE TABLE RecipeIngredient (
    RecipeID INT,
    IngredientID INT,
    Quantity DECIMAL,
    PRIMARY KEY (RecipeID, IngredientID),
    FOREIGN KEY (RecipeID) REFERENCES Recipe(RecipeID),
    FOREIGN KEY (IngredientID) REFERENCES Ingredient(IngredientID)
);



Project: MVC Project Assignment: Online Recipe Book (C# with ASP.NET MVC) 

Objective: Develop an online recipe book application that serves as a comprehensive platform for culinary enthusiasts. 
The application should: 
• Allow users to browse a wide variety of recipes from different cuisines and dietary preferences. 
• Enable users to add their unique recipes, thereby contributing to the community. 
• Provide features to edit and update recipes, ensuring that the content remains current and accurate. 
• Incorporate a user-friendly interface where recipes can be deleted with proper confirmation prompts to prevent accidental data loss. 
• Ensure that each recipe contains essential details such as ingredients, preparation time, cooking time, and step-by-step instructions. 
• Offer a responsive design that ensures a seamless experience across desktop and mobile devices.

## Setup Instructions

### Prerequisites

- [.NET Core SDK](https://dotnet.microsoft.com/download)
- [Visual Studio](https://visualstudio.microsoft.com/) or any code editor of your choice
- SQL Server or LocalDB installed (for database storage)

### Steps to Run

1.Design a database with tables for recipes and ingredients.:

USE RecipeBookBD;

CREATE TABLE Recipes (
    RecipeID INT PRIMARY KEY,
    RecipeName VARCHAR(255),
    Instructions TEXT,
    PrepTime INT,
    CookTime INT
);

USE RecipeBookBD;

CREATE TABLE Ingredients (
    IngredientID INT PRIMARY KEY,
    IngredientName VARCHAR(255)
);

1.Create the following views:
• Home Page: Display a list of recipes with their title and a brief description. 
@{
    ViewData["Title"] = "Home Page";
}

<meta name="viewport" content="width=device-width, initial-scale=1.0">

@model List<Recipe>

<h2>Recipe List</h2>

@foreach (var recipe in Model)
{
    <div>
        <h3>@recipe.RecipeName</h3>
        <p>@recipe.Description</p>
        <div>
            @Html.ActionLink("Details", "Details", new { id = recipe.RecipeID }) |
            @Html.ActionLink("Edit", "Edit", new { id = recipe.RecipeID }) |
            @Html.ActionLink("Delete", "Delete", new { id = recipe.RecipeID })
        </div>
    </div>
}

<div class="text-center">
    <h1 class="display-4">Welcome fellow foodies!</h1>
    <p>Hello there and welcome to our online cookbook. This is a place meant for sharing recipes and building a community of food lovers and cuisine connoisseurs. Find recipes that interest you, and let us know what you think. Better yet, share your recipes and let us try your unique takes on cooking! After all, this is the community for food lovers.</p>
</div>

<div class="star-recipes">
    <h1 class="display-4">Recipes to try today</h1>
    @foreach (var recipe in Model)
    {
        <div class="recipe">
            <img class="recipe-image" src="~/css/Snickerdoodles.jpg" />
            <h4 class="recipe-name">
                @Html.ActionLink(recipe.Snickerdoodles, "Details", new { id = recipe.1 })
            </h4>
            <p class="recipe-description">@recipe.Description</p>
        </div>
    }
    @foreach (var recipe in Model)
    {
        <div class="recipe">
            <img class="recipe-image" src="~/css/Lasagna.jpg" />
            <h4 class="recipe-name">
                @Html.ActionLink(recipe.Lasagna, "Details", new { id = recipe.2 })
            </h4>
            <p class="recipe-description">@recipe.Description</p>
        </div>
    }
    @foreach (var recipe in Model)
    {
        <div class="recipe">
            <img class="recipe-image" src="~/css/Churros.jpg" />
            <h4 class="recipe-name">
                @Html.ActionLink(recipe.Churros, "Details", new { id = recipe.3 })
            </h4>
            <p class="recipe-description">@recipe.Description</p>
        </div>
    }
    @foreach (var recipe in Model)
    {
        <div class="recipe">
            <img class="recipe-image" src="~/css/Alfredo.jpg" />
            <h4 class="recipe-name">
                @Html.ActionLink(recipe.FettuccineAlfredo, "Details", new { id = recipe.4 })
            </h4>
            <p class="recipe-description">@recipe.Description</p>
        </div>
    }
    @foreach (var recipe in Model)
    {
        <div class="recipe">
            <img class="recipe-image" src="~/css/pancakes.jpg" />
            <h4 class="recipe-name">
                @Html.ActionLink(recipe.Pancakes, "Details", new { id = recipe.5 })
            </h4>
            <p class="recipe-description">@recipe.Description</p>
        </div>
    }
</div>

•Recipe Details Page: Display detailed information about a recipe, including its ingredients. 
@model Recipe

<h2>@Model.RecipeName</h2>
<p>Description: @Model.Description</p>
<p>Prep Time: @Model.PrepTime minutes</p>
<p>Cook Time: @Model.CookTime minutes</p>

<h3>Ingredients</h3>
<ul>
    @foreach (var ingredient in Model.Ingredients)
    {
        <li>@ingredient.IngredientName</li>
    }
</ul>

<p>Instructions: @Model.Instructions</p>

@Html.ActionLink("Edit", "Edit", new { id = Model.RecipeID }) |
@Html.ActionLink("Back to List", "Index")

• Add/Edit Recipe Page: Provide forms for users to add new recipes or edit existing ones. 
@model Recipe
<meta name="viewport" content="width=device-width, initial-scale=1.0">


@using (Html.BeginForm())
{
    @Html.AntiForgeryToken()

    <div class="form-group">
        @Html.LabelFor(model => model.RecipeName)
        @Html.TextBoxFor(model => model.RecipeName, new { @class = "form-control" })
    </div>

    <div class="form-group">
        @Html.LabelFor(model => model.Description)
        @Html.TextBoxFor(model => model.Description, new { @class = "form-control" })
    </div>

    

    <h3>Ingredients</h3>
    <div class="form-group">
        @Html.EditorFor(model => model.Ingredients)
    </div>

    <button type="submit">Save</button>
}

@Html.ActionLink("Back to List", "Index")

• Delete Recipe Confirmation Page: Before deleting a recipe, ask the user for confirmation. 
@model Recipe
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<h2>Confirm Deletion</h2>
<p>Are you sure you want to delete the recipe "@Model.RecipeName"?</p>

@using (Html.BeginForm("DeleteConfirmed", "Recipes", new { id = Model.RecipeID }))
{
    @Html.AntiForgeryToken()
    <input type="submit" value="Delete" />
}

@Html.ActionLink("Cancel", "Details", new { id = Model.RecipeID })

3. Create the following controller
RecipeController:

using Microsoft.AspNetCore.Mvc;
using OnlineRecipeBook.Models;
using System.Diagnostics;

namespace OnlineRecipeBook.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}

4. Assumptions and Decisions
Database Choice:

The application uses Entity Framework Code-First Migrations with a SQL Server database.

User Authentication:

User authentication and authorization are not implemented in this version for simplicity.

Recipe Structure:

Each recipe consists of a name, description, preparation time, cooking time, instructions, and a list of ingredients.

Front-End Framework:
The application uses standard HTML, CSS, and Razor views for simplicity. Consider integrating a front-end framework for enhanced user experience.

Security Considerations:
Security measures, such as input validation and protection against cross-site scripting (XSS) attacks, need to be implemented.


# Bangazon Orientation API

## Table of Contents

1. [Prerequisites](#prerequisites)
1. [What You Will Be Learning](#what-you-will-be-learning)
1. [Requirements](#requirements)
1. [Resources](#resources)

## Prerequisites

* .NET Core [installed](https://www.microsoft.com/net/core#macos).
* [Visual Studio Code](https://code.visualstudio.com/), or [Visual Studio Community Edition](https://www.visualstudio.com/vs/community/) installed for existing Windows users.
* For Code users, [install the C# extension](#installing-c-extension-for-code).
* Yeoman, and the ASP.NET generator, [installed](#installing-yeoman-and-the-aspnet-generator) 

## What You Will Be Learning

### ERD

Entity Relationship Diagrams are visual representations of your database structure, and relationships between data. You will build an ERD that represents the first version of your database.

### project.json

With the release of .NET Core, the .NET platform now more closely adheres to conventions that have been adopted by the OSS community. Once of those conventions is storing project-related settings and configuration in JSON format instead of XML format.

You will understand the structure of the [`project.json`](https://docs.microsoft.com/en-us/dotnet/articles/core/tools/project-json) file, and how to use it to install dependencies for your project, along with the `dotnet restore` command.


### Annotations, Routing and DI

ASP.NET makes heavy use of [annotations](https://docs.asp.net/en/latest/data/ef-mvc/complex-data-model.html?highlight=annotation), [routing](https://docs.asp.net/en/latest/mvc/controllers/routing.html) and [dependency injection](https://docs.asp.net/en/latest/mvc/controllers/dependency-injection.html) to abstract away much of the heavy lifting that is required to build an API. By using these Magical Abstractions, far less coding and configuration is needed from an API developer.

### Models

You will define models, which are abstractions to the actual database. The model defines a table, validations on the columns in the table, and also the relationship between tables.

### Migrations

You will be using [migrations](https://docs.asp.net/en/latest/data/ef-mvc/migrations.html#migrations) in Entity Framework to handle changes and updates to your database.

### Controllers

You will learn about what role a controller has in an API, how it uses models and validates a request against the model, and an introduction to LINQ to get data from your database.

## Requirements

1. Use the Yeoman generator to build a basic Web API project.
1. Define models and controllers for the following resources.
    1. Customer
    1. Order
    1. Product
    1. LineItem
1. Ensure that you have annotations on your models to verify the data.
1. Ensure that you have the correct relationships established between your models using [navigation properties](https://docs.asp.net/en/latest/data/ef-mvc/complex-data-model.html?highlight=annotation#the-courses-and-officeassignment-navigation-properties).


## Resources

### Installing C# Extension for Code

You install this extension by pressing `F1` to open the VS Code palette. Type `ext install` to see the list of extensions. Select the C# extension.

### Installing Yeoman and the ASPNET Generator

Both of these are `npm` packages, and global installations at that, so run this command in your terminal.

```
npm install -g yo generator-aspnet
```

### Starter Configuration

> project.json

```json
{
  "dependencies": {
    "Microsoft.NETCore.App": {
      "version": "1.0.0",
      "type": "platform"
    },
    "Microsoft.AspNetCore.Mvc": "1.0.0",
    "Microsoft.AspNetCore.Server.IISIntegration": "1.0.0",
    "Microsoft.AspNetCore.Server.Kestrel": "1.0.0",
    "Microsoft.Extensions.Configuration.EnvironmentVariables": "1.0.0",
    "Microsoft.Extensions.Configuration.FileExtensions": "1.0.0",
    "Microsoft.Extensions.Configuration.Json": "1.0.0",
    "Microsoft.Extensions.Configuration.CommandLine": "1.0.0",
    "Microsoft.Extensions.Logging": "1.0.0",
    "Microsoft.Extensions.Logging.Console": "1.0.0",
    "Microsoft.Extensions.Logging.Debug": "1.0.0",
    "Microsoft.EntityFrameworkCore.Sqlite": "1.0.0",
    "Microsoft.Extensions.Options.ConfigurationExtensions": "1.0.0",
    "Microsoft.EntityFrameworkCore.Design": {
      "version": "1.0.0-preview2-final",
      "type": "build" 
    }
  },

  "tools": {
    "Microsoft.AspNetCore.Server.IISIntegration.Tools": "1.0.0-preview2-final",
    "Microsoft.EntityFrameworkCore.Tools": "1.0.0-preview2-final"
  },

  "frameworks": {
    "netcoreapp1.0": {
      "imports": [
        "dotnet5.6",
        "portable-net45+win8"
      ]
    }
  },

  "buildOptions": {
    "emitEntryPoint": true,
    "preserveCompilationContext": true
  },

  "runtimeOptions": {
    "configProperties": {
      "System.GC.Server": true
    }
  },

  "publishOptions": {
    "include": [
      "wwwroot",
      "Views",
      "Areas/**/Views",
      "appsettings.json",
      "web.config"
    ]
  },

  "scripts": {
    "postpublish": [ "dotnet publish-iis --publish-folder %publish:OutputPath% --framework %publish:FullTargetFramework%" ]
  },

  "tooling": {
    "defaultNamespace": "lol"
  }
}
```
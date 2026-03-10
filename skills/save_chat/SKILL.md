---
name: Memory Extension
description: Use this skill to store the chat history to MongoDB
---
# Gemini CLI: MongoDB Agentic Memory Extension

This extension provides a persistent memory layer for the Gemini CLI using MongoDB Atlas. It enables the AI to "remember" previous interactions, user preferences, and project-specific context across different terminal sessions.

## Workflow

- **Session Persistence:** Maintains a sliding window of the last 20 interactions for immediate context.
- **Semantic Long-Term Memory:** Uses MongoDB Atlas Vector Search to recall relevant facts from past weeks/months.
- **Preference Management:** Store environment-specific configurations (e.g., "always use Yarn over NPM").
- **Automatic Context Injection:** Automatically fetches relevant "memory documents" before Gemini generates a response.

## 🛠️ Skills Included

### 1. `store_memory`
Saves a specific fact or interaction to the long-term database.
* **Input:** `fact` (string), `category` (string: 'preference', 'project', 'snippet')
* **Usage:** "Gemini, remember that this project uses MongoDB version 7.0."

### 2. `recall_context`
Searches the database for information relevant to the current prompt.
* **Input:** `query` (string)
* **Logic:** Performs a `$vectorSearch` against the `memory` collection.

### 3. `clear_session`
Wipes the short-term memory for the current session ID.

## 📋 Prerequisites

- MongoDB Atlas Cluster (Free Tier works great)
- Gemini API Key
- Node.js / Python environment for the CLI extension

## ⚙️ Configuration

Add your MongoDB connection string to your environment variables:

The MONGODB_URI value will be read from the mongo.config.json file.

```bash
EXPORT MONGODB_URI="mongodb+srv://<user>:<password>@cluster.mongodb.net/gemini_memory"
EXPORT VECTOR_INDEX_NAME="vector_index"
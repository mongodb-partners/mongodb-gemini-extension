---
name: mongodb_mcp_tools
description: This skill helps to navigate tools available on MongoDB MCP Server. 
---
# MongoDB MCP Server Tools

The MongoDB MCP Server allows you to interact with MongoDB clusters using natural language queries from AI clients that support MCP. This page describes the MCP Server tools.

## Overview

The MongoDB MCP server provides the following tools categories:

- **Atlas tools**, which perform operations on Atlas system resources, like organizations, projects, clusters, database user accounts, and retrieving performance recommendations.

- **Local Atlas tools**, which allow you to list, connect to, create, and delete local Atlas deployments.

- **Database tools**, which perform operations such as inserting, updating, and deleting documents, and running queries and aggregation pipelines.

## MCP Server Atlas Tools

The Atlas tools are only available if you have set up Atlas API credentials as shown in [MongoDB MCP Server Configuration](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/configuration/#std-label-mcp-server-configuration).

The following table describes the Atlas tools:

<table>
<tr>
<th id="MCP%20Server%20Atlas%20Tool%20Name">
MCP Server Atlas Tool Name

</th>
<th id="Description">
Description

</th>
</tr>
<tr>
<td headers="MCP%20Server%20Atlas%20Tool%20Name">
`atlas-list-orgs`

</td>
<td headers="Description">
Returns a list of Atlas organizations.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Atlas%20Tool%20Name">
`atlas-list-projects`

</td>
<td headers="Description">
Returns a list of Atlas projects.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Atlas%20Tool%20Name">
`atlas-create-project`

</td>
<td headers="Description">
Creates a new Atlas project.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Atlas%20Tool%20Name">
`atlas-list-clusters`

</td>
<td headers="Description">
Returns list of Atlas clusters.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Atlas%20Tool%20Name">
`atlas-inspect-cluster`

</td>
<td headers="Description">
Returns information about a specific Atlas cluster.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Atlas%20Tool%20Name">
`atlas-create-free-cluster`

</td>
<td headers="Description">
Creates a free Atlas cluster.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Atlas%20Tool%20Name">
`atlas-connect-cluster`

</td>
<td headers="Description">
Connects to an Atlas cluster using the configured service account.

If you configured the MCP server without specifying a connection string, this tool creates a temporary database user with a random password to establish the connection. For details, see [Tool Details](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/tools/#std-label-mcp-tools-considerations).

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Atlas%20Tool%20Name">
`atlas-inspect-access-list`

</td>
<td headers="Description">
Returns information about the IP (Internet Protocol) and CIDR (Classless Inter-Domain Routing) ranges that can access an Atlas cluster.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Atlas%20Tool%20Name">
`atlas-create-access-list`

</td>
<td headers="Description">
Configures the IP (Internet Protocol) and CIDR (Classless Inter-Domain Routing) access list for an Atlas cluster.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Atlas%20Tool%20Name">
`atlas-list-db-users`

</td>
<td headers="Description">
Returns a list of Atlas database users.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Atlas%20Tool%20Name">
`atlas-create-db-user`

</td>
<td headers="Description">
Creates an Atlas database user.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Atlas%20Tool%20Name">
`atlas-list-alerts`

</td>
<td headers="Description">
Returns a list of alerts for an Atlas project.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Atlas%20Tool%20Name">
`atlas-get-performance-advisor`

</td>
<td headers="Description">
Returns [Performance Advisor](https://www.mongodb.com/docs/atlas/performance-advisor/#std-label-performance-advisor) recommendations for an Atlas cluster. Supports operations for suggested indexes, drop index suggestions, slow query logs, and schema suggestions. Requires [`Project Read Only`](https://www.mongodb.com/docs/atlas/reference/user-roles/#mongodb-authrole-Project-Read-Only) access or higher.

To learn more, see [Performance Advisor Tool](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/tools/#std-label-mcp-pa-tool).

</td>
</tr>
</table>

## MCP Server Local Atlas Tools

You can use the MCP Server with local Atlas deployments. To use the MCP Server tools with local Atlas deployments, you must install Docker. For an introduction to local Atlas deployments, see [Create a Local Atlas Deployment](https://www.mongodb.com/docs/atlas/cli/current/atlas-cli-deploy-local/).

The following table describes the local Atlas tools:

<table>
<tr>
<th id="MCP%20Server%20Local%20Atlas%20Tool%20Name">
MCP Server Local Atlas Tool Name

</th>
<th id="Description">
Description

</th>
</tr>
<tr>
<td headers="MCP%20Server%20Local%20Atlas%20Tool%20Name">
`atlas-local-list-deployments`

</td>
<td headers="Description">
Lists local Atlas deployments.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Local%20Atlas%20Tool%20Name">
`atlas-local-create-deployment`

</td>
<td headers="Description">
Creates a local Atlas deployment. To run this tool, you must disable [read only mode](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/configuration/enable-or-disable-features/#std-label-mcp-server-configuration-read-only-mode).

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Local%20Atlas%20Tool%20Name">
`atlas-local-connect-deployment`

</td>
<td headers="Description">
Connects to a local Atlas deployment.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Local%20Atlas%20Tool%20Name">
`atlas-local-delete-deployment`

</td>
<td headers="Description">
Deletes a local Atlas deployment. To run this tool, you must disable [read only mode](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/configuration/enable-or-disable-features/#std-label-mcp-server-configuration-read-only-mode).

</td>
</tr>
</table>For examples that run the local Atlas tools, see [Local Atlas Deployments](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/examples/#std-label-mcp-server-examples-local-atlas-deployments).

## MCP Server Database Tools

The following table describes the database tools:

<table>
<tr>
<th id="MCP%20Server%20Database%20Tool%20Name">
MCP Server Database Tool Name

</th>
<th id="Description">
Description

</th>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`connect`

</td>
<td headers="Description">
Connects to a MongoDB cluster.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`find`

</td>
<td headers="Description">
Runs a MongoDB database query.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`aggregate`

</td>
<td headers="Description">
Runs a MongoDB aggregation pipeline.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`count`

</td>
<td headers="Description">
Returns the number of documents in a collection.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`explain`

</td>
<td headers="Description">
Returns statistics describing the execution of the winning plan chosen by the query optimizer for the evaluated method.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`insert-many`

</td>
<td headers="Description">
Adds documents to a collection.

If you specify a [Voyage AI API key](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/configuration/options/#std-label-mcp-voyage-api-key) in your MCP configuration, the server can automatically generate vector embeddings from text and include them in the inserted documents.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`create-index`

</td>
<td headers="Description">
Creates an index on a collection. This tool supports creating [vector search indexes](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/tools/#std-label-mcp-vector-search-tools).

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`drop-index`

</td>
<td headers="Description">
Removes a [vector search index](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/tools/#std-label-mcp-vector-search-tools) from a collection.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`update-one`

</td>
<td headers="Description">
Modifies a single document in a collection.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`update-many`

</td>
<td headers="Description">
Modifies multiple documents in a collection.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`rename-collection`

</td>
<td headers="Description">
Changes the name of a collection.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`create-collection`

</td>
<td headers="Description">
Creates a new collection.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`delete-many`

</td>
<td headers="Description">
Removes documents from a collection.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`drop-collection`

</td>
<td headers="Description">
Deletes a collection from a database.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`drop-database`

</td>
<td headers="Description">
Deletes a database.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`drop-index`

</td>
<td headers="Description">
Drop an index for the provided database and collection.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`list-databases`

</td>
<td headers="Description">
Returns a list of all databases available through the current connection.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`list-collections`

</td>
<td headers="Description">
Returns a list of collections in a database.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`collection-indexes`

</td>
<td headers="Description">
Returns information about collection indexes, including [vector search indexes](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/tools/#std-label-mcp-vector-search-tools).

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`collection-schema`

</td>
<td headers="Description">
Returns collection [schema](https://www.mongodb.com/docs/manual/core/schema-validation/#std-label-schema-validation-overview) information.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`collection-storage-size`

</td>
<td headers="Description">
Returns collection size in megabytes.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`db-stats`

</td>
<td headers="Description">
Returns database statistics.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`export`

</td>
<td headers="Description">
Saves the results of a query or aggregation pipeline in JSON format to a file on the computer that runs the MCP Server. The results are also accessible through the `exported-data` resource in the AI client application.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`mongodb-logs`

</td>
<td headers="Description">
Returns the most recent logged `mongod` events.

</td>
</tr>
<tr>
<td headers="MCP%20Server%20Database%20Tool%20Name">
`switch-connection`

</td>
<td headers="Description">
Switch to a different MongoDB connection.

</td>
</tr>
</table>

## Tool Details

For additional information about specific MCP tools, see the following sections.

### Vector Search Support

Vector search support in MCP is available as a [preview feature](https://www.mongodb.com/docs/preview-features/). To enable this feature, set the `previewFeatures` flag or `MDB_MCP_PREVIEW_FEATURES` environment variable to `search` in your [MCP configuration](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/configuration/options/#std-label-mcp-server-configuration-options).

The MongoDB MCP Server supports [MongoDB Vector Search](https://www.mongodb.com/docs/atlas/atlas-vector-search/vector-search-overview/#std-label-avs-overview). You can create and manage vector search indexes, generate embeddings, and run semantic search queries through natural language prompts. The following table summarizes key features.

<table>
<tr>
<th id="Use%20Case">
Use Case

</th>
<th id="Example%20Prompts">
Example Prompts

</th>
<th id="Relevant%20Tools">
Relevant Tools

</th>
</tr>
<tr>
<td headers="Use%20Case">
Manage indexes

</td>
<td headers="Example%20Prompts">
`Create a vector search index on the sample_db database and products collection``Show me all vector search indexes on the products collection``Drop the vector search index named vector_index`

</td>
<td headers="Relevant%20Tools">
`create-index``collection-indexes``drop-index`

</td>
</tr>
<tr>
<td headers="Use%20Case">
Insert documents with automatic embeddings

</td>
<td headers="Example%20Prompts">
`Insert these documents into the products collection and embed their descriptions`

</td>
<td headers="Relevant%20Tools">
`insert-many`

</td>
</tr>
<tr>
<td headers="Use%20Case">
Vector search queries

</td>
<td headers="Example%20Prompts">
`Search for documents semantically similar to this description``Find me related products filtered by price range`

</td>
<td headers="Relevant%20Tools">
`aggregate`

</td>
</tr>
</table>Use the following resources to learn more:

- For detailed usage examples and sample outputs, see [Vector Search](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/examples/#std-label-mcp-server-vector-search-examples).

- To configure the MCP Server for vector search, see [Vector Search Options](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/configuration/options/#std-label-mcp-vector-search-options).

- To learn more about vector search, see [MongoDB Vector Search Overview](https://www.mongodb.com/docs/atlas/atlas-vector-search/vector-search-overview/#std-label-avs-overview).

#### Index Management

The following tools allow you to manage [vector search indexes](https://www.mongodb.com/docs/atlas/atlas-vector-search/vector-search-type/#std-label-avs-types-vector-search):

- `collection-indexes`: Lists all indexes on a collection, including vector search indexes, and provides index status information.

- `create-index`: Creates a new vector search index on a collection.

- `drop-index`: Deletes a vector search index from a collection.

To update a vector search index, drop the existing index and create a new one.

### Generate Embeddings Automatically

The MongoDB MCP Server supports two independent mechanisms for generating vector embeddings:

- **MCP Server embedding generation**: The MCP Server generates embeddings client-side using Voyage AI before sending documents to MongoDB. This requires a [Voyage AI API key](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/configuration/options/#std-label-mcp-voyage-api-key).

- **MongoDB automated embedding**: MongoDB automatically generates embeddings server-side when documents are inserted or updated. To learn more, see [MongoDB Automated Embedding](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/tools/#std-label-mcp-autoembed).

These mechanisms work independently and can be used together or separately depending on your use case.

#### MCP Server Embedding Generation

If you configure the MCP Server with a [Voyage AI API key](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/configuration/options/#std-label-mcp-voyage-api-key), the server can automatically generate embeddings in the following ways:

- **Generate embeddings for documents**: Embeds text fields in documents when using the `insert-many` tool.

- **Generates embeddings for queries**: Embeds the search query when running vector search queries with the `aggregate` tool. Specifically, the server generates embeddings for the `queryVector` parameter in [`$vectorSearch`](https://www.mongodb.com/docs/atlas/atlas-vector-search/vector-search-stage/#mongodb-pipeline-pipe.-vectorSearch) aggregation queries.

The MCP Server supports the following Voyage AI embedding models:

- `voyage-3-large`

- `voyage-3.5`

- `voyage-3.5-lite`

- `voyage-code-3`

To learn more about Voyage AI models, see the [Voyage AI documentation](https://docs.voyageai.com/docs/embeddings).

By default, the MongoDB MCP Server validates that fields with vector search indexes contain valid vector embeddings to prevent breaking vector search indexes. To disable this behavior, set the `disableEmbeddingsValidation` option to `true`. To learn more, see [Vector Search Options](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/configuration/options/#std-label-mcp-vector-search-options).

#### MongoDB Automated Embedding

Automated embedding in vector search indexes is available as a [preview feature](https://www.mongodb.com/docs/preview-features/) only for MongoDB Community Edition v8.2 and later. The feature and the corresponding documentation might change at anytime during the Preview period.

MongoDB can also automatically generate embeddings server-side when documents are inserted or updated. This approach does not require a Voyage AI API key in your MCP configuration because embedding generation happens within MongoDB.

The MongoDB MCP Server supports managing vector search indexes with automated embedding, which automatically generate embeddings for your documents. You can create, drop, and inspect vector search indexes with automated embedding through natural language prompts. The following table summarizes key features.

To learn more, see [Automated Embedding](https://dochub.mongodb.org/core/auto-embedding-in-community).

<table>
<tr>
<th id="Use%20Case">
Use Case

</th>
<th id="Relevant%20Tools">
Relevant Tools

</th>
<th id="Example%20Prompts">
Example Prompts

</th>
</tr>
<tr>
<td headers="Use%20Case">
Manage indexes

</td>
<td headers="Relevant%20Tools">
`create-index``collection-indexes``drop-index`

</td>
<td headers="Example%20Prompts">
"Create an auto embed vector search index on 'plot' field in 'mflix.movies' namespace using voyage-4-large model."

</td>
</tr>
<tr>
<td headers="Use%20Case">
Insert data with embeddings

</td>
<td headers="Relevant%20Tools">
`insert-many`

</td>
<td headers="Example%20Prompts">
"Insert these documents with the following fields and automatically generate embeddings..."

</td>
</tr>
<tr>
<td headers="Use%20Case">
Query with embeddings

</td>
<td headers="Relevant%20Tools">
`aggregate`

</td>
<td headers="Example%20Prompts">
"Run a vector search query on mflix.movies with the auto embed index on the 'plot' field."

</td>
</tr>
</table>

#### Considerations

The MongoDB MCP Server supports pre-filtering vector search queries. To learn more, see [MongoDB Vector Search Pre-Filtering](https://www.mongodb.com/docs/atlas/atlas-vector-search/vector-search-stage/#std-label-vectorSearch-agg-pipeline-filter).

The MCP server does not support the `quantization` field for vector search indexes.

### Performance Advisor Tool

The `atlas-get-performance-advisor` tool allows you to access [Performance Advisor](https://www.mongodb.com/docs/atlas/performance-advisor/#std-label-performance-advisor) recommendations through natural language queries. This tool helps you identify performance optimization opportunities by analyzing slow queries and suggesting improvements.

When performing slow query analysis, the MongoDB MCP Server retrieves a sample of slow queries, capped at 50 queries. The sample includes up to 50 most recent slow queries that match any specified conditions in your prompt to ensure optimal performance and response times.

This tool requires [`Project Read Only`](https://www.mongodb.com/docs/atlas/reference/user-roles/#mongodb-authrole-Project-Read-Only) access or higher and an M10+ cluster*. It is available with the `--readonly` flag.

*The [`Project Read Only`](https://www.mongodb.com/docs/atlas/reference/user-roles/#mongodb-authrole-Project-Read-Only) refers to the Atlas Project-level role assigned to your Service Account, *it does not refer to a database role*.

<table>
<tr>
<th id="Use%20Case">
Use Case

</th>
<th id="Example%20Prompts">
Example Prompts

</th>
<th id="Performance%20Advisor%20Operation">
Performance Advisor Operation

</th>
</tr>
<tr>
<td headers="Use%20Case">
Analyze Slow Queries

</td>
<td headers="Example%20Prompts">
`Show me my slow queries``What is slowing down my cluster?``Show me queries that are longer than 5 seconds``Show me slow writes in the website.users namespace`

</td>
<td headers="Performance%20Advisor%20Operation">
[slowQueryLogs](https://www.mongodb.com/docs/api/doc/atlas-admin-api-v2/operation/operation-listgroupprocessperformanceadvisorslowquerylogs)

</td>
</tr>
<tr>
<td headers="Use%20Case">
Index Suggestions

</td>
<td headers="Example%20Prompts">
`Are there any indexes I should create to improve performance?``What indexes do you recommend I drop?`

</td>
<td headers="Performance%20Advisor%20Operation">
[suggestedIndexes](https://www.mongodb.com/docs/api/doc/atlas-admin-api-v2/operation/operation-listgroupclusterperformanceadvisorsuggestedindexes)
[dropIndexSuggestions](https://www.mongodb.com/docs/api/doc/atlas-admin-api-v2/operation/operation-listgroupclusterperformanceadvisordropindexsuggestions)

</td>
</tr>
<tr>
<td headers="Use%20Case">
Schema Advice

</td>
<td headers="Example%20Prompts">
`Show schema recommendations for my cluster``Help me optimize my database schema`

</td>
<td headers="Performance%20Advisor%20Operation">
[schemaAdvice](https://www.mongodb.com/docs/api/doc/atlas-admin-api-v2/operation/operation-listgroupclusterperformanceadvisorschemaadvice)

</td>
</tr>
</table>For detailed usage examples and sample outputs, see [Performance Optimization](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/examples/#std-label-mcp-server-performance-examples).

### Connecting without Atlas Connection String

If you configure the MCP server without specifying a connection string to an Atlas cluster, the `atlas-connect-cluster` tool uses the configured Atlas API service account credentials to create a temporary [database user](https://www.mongodb.com/docs/atlas/security-add-mongodb-users/#std-label-mongodb-users) and establish a connection to the cluster.

The temporary database user has the following characteristics:

- Randomly generated username and password.

- By default, expires after 4 hours.

- Role assigned based on how you configured the MCP Server:

  - [`readAnyDatabase`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-atlasrole-readAnyDatabase) if you enabled [read-only mode](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/configuration/enable-or-disable-features/#std-label-mcp-server-configuration-read-only-mode) or disabled the `create`, `delete`, and `update` tool categories.

  - [`readWriteAnyDatabase`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-atlasrole-readWriteAnyDatabase) if the server has full permissions.

The MongoDB MCP Server stores user credentials in memory only and never returns or exposes the credentials in the LLM context.

## Learn More

To disable specific tools and restrict the MCP Server to read-only mode, see [MongoDB MCP Server Configuration](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/configuration/#std-label-mcp-server-configuration).

To see some MCP Server example natural language prompts, see [MongoDB MCP Server Usage Examples](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/mcp-server/examples/#std-label-mcp-server-examples).
[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/hAy2sqyY)

# Instructions

Design a E/R Model using crow's foot notation for a "Conference Review" system in which researchers submit papers for peer-reviewing. Comments written by reviewers are recorded by the system. Reviewers also answer evaluation questions for each paper they review and make recommendations regarding whether to accept or reject a paper. The data requirements for the system are summarized as follows:

- Authors of papers are uniquely identified by email. First and last names are also recorded. ✅

- Each paper is assigned a unique identifier by the system and is described by title, abstract, and the name of the electronic file associated with the paper.

- A paper may have multiple authors, but only one of the authors is designated as the "contact" author.

- Reviewers of papers are uniquely identified by email. Reviewer's first name, last name, phone number, affiliation, and topics of interest are also recorded by the system.

- Each paper is assigned between 2 and 4 reviewers. A reviewer rates each paper assigned to them on a scale of 1 to 10 in 4 categories: technical merit, readability, originality, and relevance to the conference. Finally, each reviewer provides an overall recommendation regarding each paper, which can be "strong accept", "accept", "weak accept", "borderline", "weak reject", "reject", or "strong reject".

- Each review also contains two types of written comments: one to be seen by the review committee only and the other as feedback to the authors.

Your E/R model should be able to represent the following entity sets:

- Authors
- Reviewers
- Papers

You are expected to identify attributes in relations and relationships, whenever appropriate. Key attributes should also be identified.

Your solution should also represent all relationships based on the data requirements described above. Your solution should be described (preferably) using the VS Code addon discussed in class in a file named **model.erd**. PDF or PNG formats are also accepted.

<!--  -->

# Grading

-1 every 3 missing/mistake attribute in an entity set or relationship.

-1 every 2 missing/mistake relationship feature (entity, type, or required)

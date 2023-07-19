# prompts

prompts are tested on [bard](https://bard.google.com/u/1/) and [chatGPT](https://chat.openai.com/) .

Fill the {placeholders} in order to adecuate your input.

## prompts to generate tech exercises based on learning strategies

### cooperative

---

**_target:_** teach a technique, method or procedure that requires multiple steps, layers, tools or strategies to be completed. The problem is splited into task, each person or subgroup resolve one single tab, then all together join the tasks to complete the solution. Each individual learn the basic task and learn how it integrate to build the solution.

**_examples:_**

- programming process requiring layers such as frontend, business, data
- design patterns requiring multiple producers, listeners or processors
- a graphical design with clear layers or screen areas
- perform a task requiring to call multiple methods or libraries
- compare multiple analysis, optiimzation or processes from the same data or the same context

**_prompt:_**

Write a cooperative exercise using the following problem description. Explain that each task below needs to be performed by each individual or subgroup assigned to the task in the time provided. Then, each task needs to be combined for the entire team until they come up with the final solution.

problem description: {description}

Task #1: {task 1}

Task #2: {task 2}

Task #3: {task 3}

Each task must be completed in {amount of minutes} minutes. Provide me with tips from experts in teaching using cooperative techniques. Provide only one version of the exercise description in an exciting manner. Do not include any extra tools requiring more time besides the mentioned above.

### collaborative

---

**_target:_** teach an experience, you want people to learn how to tackle a problem based on the experience and knowlegde of the whole team. People are provoked to conduct discussions. Ideas need to arise. The skills of the team need to be organized in order to get the most out of each individual. The final goal has to be achieved by the collaboration of all people. People are invited to provide ideas and defend their ideas, and to convince others.

**_examples:_**

- the problem or algorithm has multiple techniques to be resolved
- looking for the best possible design or solution
- to understand and find the answer all members needs to research and discuss findings
- discuss soft skills or management situations or analyze cases

**_prompt:_**

Write a collaborative exercise using the following problem description. Explain that the team needs to organize itself to accomplish the answer. Encourage team members to allocate their efforts to what they each perform better, and emphasize the importance of listening to opinions, ideas, and everyone's point of views to achieve the answer.

problem description: {problem or case description}

The problem must be completed in {amount of time} minutes. Provide me with tips from experts in teaching using collaborative techniques. Provide only one version of the exercise description in an exciting manner. Do not include any extra tools requiring more time besides the mentioned above. Do not suggest to divide the team in groups, all of them have to work together.

### autonomous

---

**_target:_** Looking to transfer practices, knowledge, techniques, or experiences to individuals. This technique is important when the individual is required to acquire specific skills that they will perform themselves. Follow the principle of "learning by doing."

**_examples:_**

- learn a programming language or framework
- learn how to perform tasks in a specific tool
- learn an algorithm

**_prompt:_**

Write a technical exercise using the problem description bellow. Explain in the exercise to the reader that he has to follow the steps and each step might have support links with info to clarify how to perform the step but also is able to ask to the instructor. Describe the steps with more details and clarifications.

problem description: {description}

steps:

1. {step}, {optional support link}
2. {step}, {optional support link}

The problem must be completed in {amount of time} minutes. Provide me with tips to solve this topic. Do not include any extra tools requiring more time besides the mentioned above. This task have to be perform individually.

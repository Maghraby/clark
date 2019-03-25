# Reward Pointing System

Implement a system for calculating rewards based on recommendations of customers.

# Task Background

A company is planning a way to reward customers for inviting their friends. They're planning a reward system that will give a customer points for each confirmed invitation they played a part into. The definition of a confirmed invitation is one where an invited person accepts their contract. Inviters also should be rewarded when someone they have invited invites more people.
The inviter gets (1/2)^k points for each confirmed invitation, where k is the level of the invitation: level 0 (people directly invited) yields 1 point, level 1 (people invited by someone invited by the original customer) gives 1/2 points, level 2 invitations (people invited by someone on level 1) awards 1/4 points and so on. Only the first invitation counts: multiple invites sent to the same person don't produce any further points, even if they come from different inviters and only the first invitation counts.

# Implementations

Ruby on rails projects using Service Objects https://medium.com/selleo/essential-rubyonrails-patterns-part-1-service-objects-1af9f9573ca1
Projects splitted into services:
- Validator to validate the data.
- Parsing for parsing the upcomming data.
- Errors for handling errors.
- Node for reward chains.
- Calculator for calculating the reward pointing.

## Prerequisite

Make sure that you install `Ruby v2.5`

## Development

#### Clone the source

```shell
git clone https://github.com/Maghraby/clark.git
```

#### Installing

Running this command will install all required gems.
```shell
cd clark
bundle install
```

#### Running

```ruby
bin/rails s
```

```shell
curl -X POST localhost:3000 --data-binary file_path_here -H "Content-Type: text/plain"
```


#### Testing

```shell
rspec
```
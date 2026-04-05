#! /usr/bin/env ruby
# Ruby version 3.1
# Nokogiri version 1.18
# Example usage: ./process.rb treebanks/homer/* > ~/Desktop/hom-v1.csv

require 'nokogiri'
require 'csv'
require 'optparse'

FEATURES = %w[ov an gn adpn]

def metadata_from_key(key)
  {
    "Matthew 1": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 2": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 3": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 4": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 5": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 6": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 7": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 8": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 9": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 10": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 11": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 12": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 13": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 14": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 15": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 16": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 17": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 18": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 19": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 20": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 21": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 22": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 23": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 24": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 25": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 26": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 27": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },
    "Matthew 28": { "author": "Matthew", "year": 85, "genre": "Prose", "work": "Gospel of Matthew" },

    "Mark 1": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 2": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 3": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 4": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 5": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 6": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 7": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 8": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 9": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 10": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 11": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 12": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 13": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 14": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 15": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },
    "Mark 16": { "author": "Mark", "year": 70, "genre": "Prose", "work": "Gospel of Mark" },

    "Luke 1": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 2": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 3": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 4": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 5": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 6": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 7": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 8": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 9": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 10": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 11": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 12": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 13": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 14": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 15": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 16": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 17": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 18": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 19": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 20": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 21": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 22": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 23": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },
    "Luke 24": { "author": "Luke", "year": 85, "genre": "Prose", "work": "Gospel of Luke" },

    "John 1": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 2": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 3": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 4": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 5": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 6": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 7": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 8": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 9": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 10": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 11": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 12": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 13": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 14": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 15": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 16": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 17": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 18": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 19": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 20": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },
    "John 21": { "author": "John", "year": 95, "genre": "Prose", "work": "Gospel of John" },

    "Acts 1": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 2": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 3": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 4": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 5": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 6": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 7": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 8": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 9": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 10": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 11": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 12": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 13": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 14": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 15": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 16": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 17": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 18": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 19": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 20": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 21": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 22": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 23": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 24": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 25": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 26": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 27": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },
    "Acts 28": { "author": "Luke", "year": 85, "genre": "History", "work": "Acts of the Apostles" },

    "Romans 1": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 2": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 3": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 4": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 5": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 6": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 7": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 8": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 9": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 10": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 11": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 12": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 13": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 14": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 15": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },
    "Romans 16": { "author": "Paul", "year": 57, "genre": "Epistolary", "work": "Letter to the Romans" },

    "1 Corinthians 1": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 2": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 3": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 4": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 5": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 6": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 7": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 8": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 9": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 10": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 11": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 12": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 13": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 14": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 15": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },
    "1 Corinthians 16": { "author": "Paul", "year": 54, "genre": "Epistolary", "work": "First Letter to the Corinthians" },

    "2 Corinthians 1": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Second Letter to the Corinthians" },
    "2 Corinthians 2": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Second Letter to the Corinthians" },
    "2 Corinthians 3": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Second Letter to the Corinthians" },
    "2 Corinthians 4": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Second Letter to the Corinthians" },
    "2 Corinthians 5": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Second Letter to the Corinthians" },
    "2 Corinthians 6": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Second Letter to the Corinthians" },
    "2 Corinthians 7": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Second Letter to the Corinthians" },
    "2 Corinthians 8": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Second Letter to the Corinthians" },
    "2 Corinthians 9": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Second Letter to the Corinthians" },
    "2 Corinthians 10": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Second Letter to the Corinthians" },
    "2 Corinthians 11": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Second Letter to the Corinthians" },
    "2 Corinthians 12": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Second Letter to the Corinthians" },
    "2 Corinthians 13": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Second Letter to the Corinthians" },

    "Galatians 1": { "author": "Paul", "year": 48, "genre": "Epistolary", "work": "Letter to the Galatians" },
    "Galatians 2": { "author": "Paul", "year": 48, "genre": "Epistolary", "work": "Letter to the Galatians" },
    "Galatians 3": { "author": "Paul", "year": 48, "genre": "Epistolary", "work": "Letter to the Galatians" },
    "Galatians 4": { "author": "Paul", "year": 48, "genre": "Epistolary", "work": "Letter to the Galatians" },
    "Galatians 5": { "author": "Paul", "year": 48, "genre": "Epistolary", "work": "Letter to the Galatians" },
    "Galatians 6": { "author": "Paul", "year": 48, "genre": "Epistolary", "work": "Letter to the Galatians" },

    "Ephesians 1": { "author": "Pseudo-Paul", "year": 90, "genre": "Epistolary", "work": "Letter to the Ephesians" },
    "Ephesians 2": { "author": "Pseudo-Paul", "year": 90, "genre": "Epistolary", "work": "Letter to the Ephesians" },
    "Ephesians 3": { "author": "Pseudo-Paul", "year": 90, "genre": "Epistolary", "work": "Letter to the Ephesians" },
    "Ephesians 4": { "author": "Pseudo-Paul", "year": 90, "genre": "Epistolary", "work": "Letter to the Ephesians" },
    "Ephesians 5": { "author": "Pseudo-Paul", "year": 90, "genre": "Epistolary", "work": "Letter to the Ephesians" },
    "Ephesians 6": { "author": "Pseudo-Paul", "year": 90, "genre": "Epistolary", "work": "Letter to the Ephesians" },

    "Philippians 1": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Letter to the Philippians" },
    "Philippians 2": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Letter to the Philippians" },
    "Philippians 3": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Letter to the Philippians" },
    "Philippians 4": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Letter to the Philippians" },

    "Colossians 1": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Colossians" },
    "Colossians 2": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Colossians" },
    "Colossians 3": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Colossians" },
    "Colossians 4": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Colossians" },

    "1 Thessalonians 1": { "author": "Paul", "year": 50, "genre": "Epistolary", "work": "First Letter to the Thessalonians" },
    "1 Thessalonians 2": { "author": "Paul", "year": 50, "genre": "Epistolary", "work": "First Letter to the Thessalonians" },
    "1 Thessalonians 3": { "author": "Paul", "year": 50, "genre": "Epistolary", "work": "First Letter to the Thessalonians" },
    "1 Thessalonians 4": { "author": "Paul", "year": 50, "genre": "Epistolary", "work": "First Letter to the Thessalonians" },
    "1 Thessalonians 5": { "author": "Paul", "year": 50, "genre": "Epistolary", "work": "First Letter to the Thessalonians" },

    "2 Thessalonians 1": { "author": "Pseudo-Paul", "year": 90, "genre": "Epistolary", "work": "Second Letter to the Thessalonians" },
    "2 Thessalonians 2": { "author": "Pseudo-Paul", "year": 90, "genre": "Epistolary", "work": "Second Letter to the Thessalonians" },
    "2 Thessalonians 3": { "author": "Pseudo-Paul", "year": 90, "genre": "Epistolary", "work": "Second Letter to the Thessalonians" },

    "1 Timothy 1": { "author": "Pastoral-Paul", "year": 100, "genre": "Epistolary", "work": "First Letter to Timothy" },
    "1 Timothy 2": { "author": "Pastoral-Paul", "year": 100, "genre": "Epistolary", "work": "First Letter to Timothy" },
    "1 Timothy 3": { "author": "Pastoral-Paul", "year": 100, "genre": "Epistolary", "work": "First Letter to Timothy" },
    "1 Timothy 4": { "author": "Pastoral-Paul", "year": 100, "genre": "Epistolary", "work": "First Letter to Timothy" },
    "1 Timothy 5": { "author": "Pastoral-Paul", "year": 100, "genre": "Epistolary", "work": "First Letter to Timothy" },
    "1 Timothy 6": { "author": "Pastoral-Paul", "year": 100, "genre": "Epistolary", "work": "First Letter to Timothy" },

    "2 Timothy 1": { "author": "Pastoral-Paul", "year": 100, "genre": "Epistolary", "work": "Second Letter to Timothy" },
    "2 Timothy 2": { "author": "Pastoral-Paul", "year": 100, "genre": "Epistolary", "work": "Second Letter to Timothy" },
    "2 Timothy 3": { "author": "Pastoral-Paul", "year": 100, "genre": "Epistolary", "work": "Second Letter to Timothy" },
    "2 Timothy 4": { "author": "Pastoral-Paul", "year": 100, "genre": "Epistolary", "work": "Second Letter to Timothy" },

    "Titus 1": { "author": "Pastoral-Paul", "year": 100, "genre": "Epistolary", "work": "Letter to Titus" },
    "Titus 2": { "author": "Pastoral-Paul", "year": 100, "genre": "Epistolary", "work": "Letter to Titus" },
    "Titus 3": { "author": "Pastoral-Paul", "year": 100, "genre": "Epistolary", "work": "Letter to Titus" },

    "Philemon 1": { "author": "Paul", "year": 55, "genre": "Epistolary", "work": "Letter to Philemon" },

    "Hebrews 1": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Hebrews" },
    "Hebrews 2": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Hebrews" },
    "Hebrews 3": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Hebrews" },
    "Hebrews 4": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Hebrews" },
    "Hebrews 5": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Hebrews" },
    "Hebrews 6": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Hebrews" },
    "Hebrews 7": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Hebrews" },
    "Hebrews 8": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Hebrews" },
    "Hebrews 9": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Hebrews" },
    "Hebrews 10": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Hebrews" },
    "Hebrews 11": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Hebrews" },
    "Hebrews 12": { "author": "Pseudo-Paul", "year": 80, "genre": "Epistolary", "work": "Letter to the Hebrews" },

    "James 1": { "author": "Pseudo-James", "year": 90, "genre": "Epistolary", "work": "Letter of James" },
    "James 2": { "author": "Pseudo-James", "year": 90, "genre": "Epistolary", "work": "Letter of James" },
    "James 3": { "author": "Pseudo-James", "year": 90, "genre": "Epistolary", "work": "Letter of James" },
    "James 4": { "author": "Pseudo-James", "year": 90, "genre": "Epistolary", "work": "Letter of James" },
    "James 5": { "author": "Pseudo-James", "year": 90, "genre": "Epistolary", "work": "Letter of James" },

    "1 Peter 1": { "author": "Pseudo-Peter", "year": 80, "genre": "Epistolary", "work": "First Letter of Peter" },
    "1 Peter 2": { "author": "Pseudo-Peter", "year": 80, "genre": "Epistolary", "work": "First Letter of Peter" },
    "1 Peter 3": { "author": "Pseudo-Peter", "year": 80, "genre": "Epistolary", "work": "First Letter of Peter" },

    "3 John 1": { "author": "Elder John", "year": 100, "genre": "Epistolary", "work": "Third Letter of John" },

    "Jude 1": { "author": "Pseudo-Jude", "year": 90, "genre": "Epistolary", "work": "Letter of Jude" },

    "Revelation 1": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 2": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 3": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 4": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 5": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 6": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 7": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 8": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 9": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 10": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 11": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 12": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 13": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 14": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 15": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 16": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 17": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 18": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 19": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 20": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 21": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" },
    "Revelation 22": { "author": "John of Patmos", "year": 95, "genre": "Prose", "work": "Revelation" }
  }[key.to_sym]
end

def letter_to_mood(letter)
  {
    'i' => 'Indicative',
    's' => 'Subjunctive',
    'o' => 'Optative',
    'n' => 'Infinitive',
    'm' => 'Imperative',
    'p' => 'Participle',
  }[letter]
end

# Convert from parsed XML to tree
def transform_sentence(node)
  words = node.xpath('./token').sort_by { |w| w[:id].to_i }
  sentence = {}
  words.each { |w| sentence[w[:id]] = { children: [] } }

  words.each do |w|
    word = sentence[w[:id]]

    word[:id] = w[:id]
    word[:head] = w[:'head-id']
    word[:postag] = w[:morphology]
    word[:pos] = w[:'part-of-speech']
    word[:relation] = w[:relation]
    word[:lemma] = w[:lemma]
    word[:'empty-token-sort'] = w[:'empty-token-sort']

    if sentence.member?(word[:head]) 
      sentence[word[:head]][:children].push(w[:id])
    end
  end

  [node[:id], sentence]
end

# Take sentence in tree format and convert to CSV line
def sentence_to_csv(sentence, options)
  heads = {}
  csv = []

  sentence_map = {}
  sentence.each do |id, node|
    sentence_map[id] = node
  end

  sentence.each do |id, node|
    next if node[:'empty-token-sort']

    case options[:feature]
    when 'ov'
      if node[:pos] == 'V-'
        mood = letter_to_mood(node[:postag][3])
        next unless mood

        heads[id] ||= {}
        heads[id][:order] ||= {}
        heads[id][:order][:v] = heads[id][:order].size + 1
        heads[id][:mood] = mood

        if node[:relation] == 'pred'
          heads[id][:clause] = 'NA'
        else
          heads[id][:clause] = 'NA'
        end
      else
        head = (heads[node[:head]] ||= {})

        # If the node is an object in the accusative
        if node[:relation] == 'obj' && node[:postag][6] == 'a' && (node[:pos] == 'Nb' || node[:pos] == 'Ne')
          head[:order] ||= {}
          # ||= for duplicate objects
          head[:order][:o] ||= head[:order].size + 1
        end
      end

    when 'an'
      if node[:pos] == 'Nb' || node[:pos] == 'Ne' # noun
        heads[id] ||= {}
        heads[id][:order] ||= {}
        heads[id][:order][:n] = heads[id][:order].size + 1
      elsif node[:pos] == 'A-' && node[:relation] == 'atr' # adjective
        head = (heads[node[:head]] ||= {})
        head[:order] ||= {}
        head[:order][:a] ||= head[:order].size + 1
      end

    when 'gn'
      if (node[:pos] == 'Nb' || node[:pos] == 'Ne') && node[:postag][6] != 'g' # noun NOT in the genitive
        heads[id] ||= {}
        heads[id][:order] ||= {}
        heads[id][:order][:n] = heads[id][:order].size + 1
      elsif (node[:pos] == 'Nb' || node[:pos] == 'Ne') && node[:postag][6] == 'g' && node[:relation] == 'atr' # noun in genitive
        head = (heads[node[:head]] ||= {})
        head[:order] ||= {}
        head[:order][:g] ||= head[:order].size + 1
      end

    when 'adpn'
      if node[:pos] == 'R-' # adposition
        heads[id] ||= {}
        heads[id][:order] ||= {}
        heads[id][:order][:a] = heads[id][:order].size + 1
      elsif node[:pos] == 'Nb' || node[:pos] == 'Ne' # nominal argument of adposition
        head = (heads[node[:head]] ||= {})
        head[:order] ||= {}
        head[:order][:n] ||= head[:order].size + 1
      end
    end
  end

  heads.each do |_, head|
    case options[:feature]
    when 'ov'
      next unless (order = head[:order]) && order[:v] && order[:o]

      label = {
        [1, 2] => 'VO',
        [2, 1] => 'OV',
      }[[order[:v], order[:o]]]

      csv.push([head[:clause], head[:mood], label])

    when 'an'
      next unless (order = head[:order]) && order[:n] && order[:a]

      label = {
        [1, 2] => 'NA',
        [2, 1] => 'AN',
      }[[order[:n], order[:a]]]

      csv.push([label])

    when 'gn'
      next unless (order = head[:order]) && order[:n] && order[:g]

      label = {
        [1, 2] => 'NG',
        [2, 1] => 'GN',
      }[[order[:n], order[:g]]]

      csv.push([label])

    when 'adpn'
      next unless (order = head[:order]) && order[:n] && order[:a]

      label = {
        [1, 2] => 'NA',
        [2, 1] => 'AN',
      }[[order[:n], order[:a]]]

      csv.push([label])
    end
  end

  csv
end

options = {
  feature: FEATURES.first,
}

OptionParser.new do |opts|
  opts.banner = "Usage: #{$PROGRAM_NAME} [--feature FEATURE] file1.xml [file2.xml ...]"

  opts.on('--feature FEATURE', FEATURES, "Feature: #{FEATURES.join(', ')} (default: #{options[:feature]})") do |feature|
    options[:feature] = feature
  end

  opts.on('-h', '--help', 'Show this message') do
    puts opts
    exit
  end
end.parse!(ARGV)

errors = []
if ARGV.empty?
  errors << 'Error: you must provide at least one XML filename'
end

if errors.any?
  errors.each { |e| puts e }
  exit 1
end

ARGV.each do |filename|
  xml = File.open(filename) { |f| Nokogiri::XML(f) }

  texts = xml.xpath('//div')

  texts.each do |text|
    title = text.xpath('./title').text

    author = metadata_from_key(title)[:author]
    work = metadata_from_key(title)[:work]
    year = metadata_from_key(title)[:year]
    genre = metadata_from_key(title)[:genre]

    text.xpath('./sentence')
      .map { |n| transform_sentence(n) }
      .map { |id, s| [sentence_to_csv(s, options), id] }
      .each { |c, id| c.each { |r| print CSV.generate_line(["#{filename}-#{title}", author, work, year, genre, id] + r) } }
  end
end

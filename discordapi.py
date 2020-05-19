import os
from dotenv import load_dotenv
import discord
from discord.ext import commands
from multiprocessing import Process
import threading
import asyncio
import time

messages = []
currentGuild = None
currentChannel = None

readyFlag = False

load_dotenv()
TOKEN = os.getenv('DISCORD_TOKEN')

client = commands.Bot(command_prefix='~')


@client.event
async def on_ready():
    print(f'{client.user} is connected.')


def run():
    client.run(TOKEN)

async def update_stats():
    global readyFlag
    global messages
    global currentGuild
    global currentChannel

    await client.wait_until_ready()

    currentGuild = client.guilds[0]
    currentChannel = currentGuild.channels[1]
    await getMessages(currentChannel)
    
    readyFlag = True

async def getMessages(channel):
    async for message in channel.history(limit=100):
        messages.append(message)


async def printGuilds():
    for guild in client.guilds:
        print(f'https://cdn.discordapp.com/icons/{guild.id}/{guild.icon}.png')



async def check():
    await update_stats()
    print(messages)

def start():
    t1 = threading.Thread(target=run)
    t1.start()
    client.loop.create_task(update_stats())

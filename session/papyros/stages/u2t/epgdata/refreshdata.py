import os, re
from subprocess import check_output, call, STDOUT

channels = open("channels.txt", "r")
for line in channels:
    line = line.strip()
    if len(line) == 0:
        continue

    epg, logo = line.split("|")
    name = epg.split("/")[3]
    print "==== Channel %s ====" % name

    channeldir = os.path.join("channels", name)
    if not os.path.exists(channeldir):
        os.makedirs(channeldir)

    print "Fetching EPG information..."
    print check_output(["wget", epg + ".xml", "-nv", "-O",
                        os.path.join(channeldir, "epg.xml")], stderr=STDOUT).strip()

    print "Fetching channel logo..."
    print check_output(["wget", logo, "-nv", "-O",
                        os.path.join(channeldir, "logo.gif")], stderr=STDOUT).strip()

    pixelinfo = check_output(["convert", os.path.join(channeldir, "logo.gif"), "-crop", "1x1+5+5", "txt:-"])
    result = re.search("(#[A-F0-9]+)", pixelinfo.split("\n")[1])
    color = result.groups()[0]
    print "Rescaling channel logo, using %s as filler color..." % color

    call(["convert", os.path.join(channeldir, "logo.gif"),
          "-shave", "1x1", "-gravity", "center", "-background", color,
          "-resize", "200x78", "-extent", "200x78",
          os.path.join(channeldir, "logo.png")])

    print "Creating recolored version..."
    call(["convert",  os.path.join(channeldir, "logo.png"),
          "-type", "Grayscale",
          os.path.join(channeldir, "logo_bw.png")])

    os.remove(os.path.join(channeldir, "logo.gif"))
    print ""


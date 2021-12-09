from os.path import exists
for i in range(1,26):
    files = {
        "input": f"d{i}_input.txt",
        "testinput": f"d{i}_testinput.txt",
        "script": f"d{i}.py",
    }
    
    for key in files:
        if not exists(files[key]):
            contents = ""
            if key == "script":
                contents = f"with open('{files['testinput']}', 'r') as f:\n"
                contents += "\tlines = [j.replace('\\n','') for j in f.readlines() if j != '\\n']"   
                contents += "\n\n#part1\n\n\n#part2"
            f = open(files[key],'w'); f.write(contents); f.close()


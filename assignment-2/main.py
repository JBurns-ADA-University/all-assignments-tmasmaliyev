instructions = [ 
    0xE3A02000, 
    0xE1A03001, 
    0xE1510000, 
    0x8A000002, 
    0xE2822001, 
    0xE0811003, 
    0xEAFFFFFA, 
    0xE1A00002 
] 

with open('test.bin', 'wb') as f: 
    for instruction in instructions: 
        f.write(instruction.to_bytes(4, byteorder='little')) 

print('Done building !') 
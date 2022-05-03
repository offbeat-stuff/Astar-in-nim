import tables

var pointTable* = initTable[(int,int),seq[(int,int)]]()

var surroundingPoints* : seq[(int,int)] = @[(0, -1), (0, 1), (0, -2), (0, 2), (0, -3), (0, 3), (1, 0), (-1, 0), (1, -1), (1, 1), (-1, 1), (-1, -1), (1, -2), (1, 2), (-1, 2), (-1, -2), (2, 0), (-2, 0), (2, -1), (2, 1), (-2, 1), (-2, -1), (2, -2), (2, 2), (-2, 2), (-2, -2), (3, 0), (-3, 0)]

pointTable[(0,-1)] = @[]
pointTable[(0,1)] = @[]
pointTable[(0,-2)] = @[(0, -1)]
pointTable[(0,2)] = @[(0, 1)]
pointTable[(0,-3)] = @[(0, -1), (0, -2)]
pointTable[(0,3)] = @[(0, 1), (0, 2)]
pointTable[(1,0)] = @[]
pointTable[(-1,0)] = @[]
pointTable[(1,-1)] = @[(0, -1), (1, 0)]
pointTable[(1,1)] = @[(0, 1), (1, 0)]
pointTable[(-1,1)] = @[(0, 1), (-1, 0)]
pointTable[(-1,-1)] = @[(0, -1), (-1, 0)]
pointTable[(1,-2)] = @[(0, -1), (0, -2), (1, 0), (1, -1)]
pointTable[(1,2)] = @[(0, 1), (0, 2), (1, 0), (1, 1)]
pointTable[(-1,2)] = @[(0, 1), (0, 2), (-1, 0), (-1, 1)]
pointTable[(-1,-2)] = @[(0, -1), (0, -2), (-1, 0), (-1, -1)]
pointTable[(2,0)] = @[(1, 0)]
pointTable[(-2,0)] = @[(-1, 0)]
pointTable[(2,-1)] = @[(0, -1), (1, 0), (1, -1), (2, 0)]
pointTable[(2,1)] = @[(0, 1), (1, 0), (1, 1), (2, 0)]
pointTable[(-2,1)] = @[(0, 1), (-1, 0), (-1, 1), (-2, 0)]
pointTable[(-2,-1)] = @[(0, -1), (-1, 0), (-1, -1), (-2, 0)]
pointTable[(2,-2)] = @[(0, -1), (1, 0), (1, -1), (1, -2), (2, -1)]
pointTable[(2,2)] = @[(0, 1), (1, 0), (1, 1), (1, 2), (2, 1)]
pointTable[(-2,2)] = @[(0, 1), (-1, 0), (-1, 1), (-1, 2), (-2, 1)]
pointTable[(-2,-2)] = @[(0, -1), (-1, 0), (-1, -1), (-1, -2), (-2, -1)]
pointTable[(3,0)] = @[(1, 0), (2, 0)]
pointTable[(-3,0)] = @[(-1, 0), (-2, 0)]

using System.Collections.Generic;
using System.Linq;

namespace Solutions.Day07
{
    class Node
    {
        readonly int size;
        readonly public Dictionary<string, Node> children;
        public Node Parent { get; private set; }

        public Node(int size, Node parent = null)
        {
            this.size = size;
            children = new();
            Parent = parent;
        }

        public Node AddChildIfNeeded(string name, int size)
        {
            if (!children.ContainsKey(name))
            {
                Node child = new(size, this);
                children[name] = child;
            }
            return children[name];
        }

        public int CalculateTotalSize()
        {
            return size + children.Select(x => x.Value.CalculateTotalSize()).Sum();
        }

        public int CalculateTotalSizeOfDirectoriesRecursively()
        {
            if (children.Count == 0)
                return 0;

            var totalChildrenSize = children.Select(x => x.Value.CalculateTotalSize()).Sum();

            var result = children.Select(x => x.Value.CalculateTotalSizeOfDirectoriesRecursively()).Sum();
            if (size + totalChildrenSize <= 100_000)
                result += totalChildrenSize + size;

            return result;
        }
    }

    public class Solution
    {
        static Node CreateFilesystem(List<string> input)
        {
            Node root = new(0);
            Node currentNode = root;
            foreach (var line in input.Skip(1))
            {
                var words = line.Split(' ');
                if (words[0] == "$" && words[1] == "cd")
                {
                    if (words[2] == "..")
                        currentNode = currentNode.Parent;
                    else
                        currentNode = currentNode.AddChildIfNeeded(words[2], 0);
                }
                else if (words[0] != "$")
                {
                    if (words[0] == "dir")
                        currentNode.AddChildIfNeeded(words[1], 0);
                    else
                        currentNode.AddChildIfNeeded(words[1], int.Parse(words[0]));
                }
            }
            return root;
        }

        public static string Part1(List<string> input)
        {
            Node root = CreateFilesystem(input);
            return root.CalculateTotalSizeOfDirectoriesRecursively().ToString();
        }

        public static string Part2(List<string> input)
        {
            Node root = CreateFilesystem(input);
            var amontOfFreeSpace = 70_000_000 - root.CalculateTotalSize();
            var minimumFreedSpace = 30_000_000 - amontOfFreeSpace;
            var currentSmallestDirectory = root;

            void findSmallestDirectory(Node node)
            {
                if (node.children.Count == 0)
                    return;

                var nodeSize = node.CalculateTotalSize();
                if (nodeSize > minimumFreedSpace && nodeSize < currentSmallestDirectory.CalculateTotalSize())
                    currentSmallestDirectory = node;

                foreach (var (_, child) in node.children)
                {
                    findSmallestDirectory(child);
                }
            }

            findSmallestDirectory(root);
            return currentSmallestDirectory.CalculateTotalSize().ToString();
        }
    }
}

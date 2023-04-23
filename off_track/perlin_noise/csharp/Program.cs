/*
 
rm /tmp/csharp-white-noise.ppm && dotnet run && eog /tmp/csharp-white-noise.ppm
dotnet build -c Release WhiteNoise.csproj

$ time ./bin/Release/net7.0/WhiteNoise 

real    0m0.131s
user    0m0.086s
sys     0m0.024s

 */

using static System.Text.Encoding;

namespace WhiteNoise;

internal record Dimension(int Width, int Height);

internal record Color(float R, float G, float B);

internal static class Pattern
{
    private const string PpmMagicNumber = "P6";
    private static readonly string NewLine = Environment.NewLine;

    public static void Generate(Dimension dim, Color[] colors, string filepath)
    {
        const int maxValue = 0xff;
        var rand = new Random();
        using var fileStream = new FileStream(filepath, FileMode.Create);
        using var bufStream = new BufferedStream(fileStream, 4096);

        bufStream.Write(ASCII.GetBytes($"{PpmMagicNumber}{NewLine}"));
        bufStream.Write(ASCII.GetBytes($"{dim.Width} {dim.Height}{NewLine}"));
        bufStream.Write(ASCII.GetBytes($"{maxValue}{NewLine}"));

        for (var x = 0; x < dim.Width; x++)
        {
            for (var y = 0; y < dim.Height; y++)
            {
                var randIdx = rand.Next(0, colors.Length);
                var col = colors[randIdx];
                byte[] rgb =
                {
                    (byte) (col.R * maxValue),
                    (byte) (col.G * maxValue),
                    (byte) (col.B * maxValue)
                };
                bufStream.Write(rgb);
            }
        }
    }
}

internal static class Program
{
    public static void Main()
    {
        var dim = new Dimension(512, 512);
        Color[] colors =
        {
            new Color(0.4078f, 0.4078f, 0.3764f),
            new Color(0.7606f, 0.6274f, 0.6313f),
            new Color(0.8980f, 0.9372f, 0.9725f),
        };
        const string filepath = "/tmp/csharp-white-noise.ppm";
        Pattern.Generate(dim, colors, filepath);

        Console.WriteLine($"Pattern generated at: {filepath}");
    }
}
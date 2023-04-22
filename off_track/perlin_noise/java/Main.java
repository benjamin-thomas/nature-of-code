import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.concurrent.ThreadLocalRandom;

/*

Mimic IntelliJ's behaviour with:

    ./manage/build && ./manage/run

Re-run on file save:

    echo ./Main.java | entr -c bash -c './manage/build && ./manage/run'
 */
record Dimension(int width, int height) {
}

record Color(float r, float g, float b) {
}

class Pattern {
    public static final String PPM_MAGIC_NUMBER = "P6";
    static final String newLine = System.getProperty("line.separator");

    static void generate(Dimension dim, Color[] colors,
                         @SuppressWarnings("SameParameterValue") String filepath) throws IOException {

        var maxValue = 0xff;
        var file = new File(filepath);
        try (FileOutputStream fos = new FileOutputStream(file)) {

            byte[] ppmBytes = (PPM_MAGIC_NUMBER + newLine).getBytes();
            fos.write(ppmBytes);

            fos.write((dim.width() + " " + dim.height() + newLine).getBytes());
            fos.write((maxValue + newLine).getBytes());

            for (int x = 0; x < dim.width(); x++) {
                for (int y = 0; y < dim.height(); y++) {
                    int randIdx = ThreadLocalRandom.current().nextInt(0, colors.length);
                    var col = colors[randIdx];
                    byte[] rgb = {
                            (byte) (col.r() * maxValue),
                            (byte) (col.g() * maxValue),
                            (byte) (col.b() * maxValue)};
                    fos.write(rgb);

                }
            }
        }
    }
}

class Main {

    public static void main(String[] args) throws IOException {
        var dim = new Dimension(512, 512);
        Color[] colors = {
                new Color(0.4078f, 0.4078f, 0.3764f),
                new Color(0.7606f, 0.6274f, 0.6313f),
                new Color(0.8980f, 0.9372f, 0.9725f),
        };
        String filepath = "/tmp/java-white-noise.ppm";
        Pattern.generate(dim, colors, filepath);

        System.out.println("Pattern generated at: " + filepath);
    }


}

using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;

namespace GameProject {
    public static class Assets {
        public static Texture2D Square;
        public static Effect Linear;
        public static Effect Expo;
        public static Effect Color;
        public static Effect Noise;

        public static void Setup(ContentManager content) {
            LoadTextures(content);
            LoadShaders(content);
        }

        public static void LoadTextures(ContentManager content) {
            Square = content.Load<Texture2D>("square");
        }
        public static void LoadShaders(ContentManager content) {
            Linear = content.Load<Effect>("linear");
            Expo = content.Load<Effect>("expo");
            Color = content.Load<Effect>("color");
            Noise = content.Load<Effect>("noise");
            Expo.Parameters["exponent"].SetValue(5f);
        }
    }
}

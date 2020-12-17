using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using Apos.Input;

namespace GameProject {
    public class GameRoot : Game {
        public GameRoot() {
            _graphics = new GraphicsDeviceManager(this);
            IsMouseVisible = true;
            Content.RootDirectory = "Content";
        }

        protected override void Initialize() {
            Window.AllowUserResizing = true;
            _graphics.PreferredBackBufferWidth = 1700;
            _graphics.PreferredBackBufferHeight = 900;
            _graphics.ApplyChanges();

            base.Initialize();
        }

        protected override void LoadContent() {
            _s = new SpriteBatch(GraphicsDevice);

            Assets.Setup(Content);

            InputHelper.Setup(this);
        }

        protected override void Update(GameTime gameTime) {
            InputHelper.UpdateSetup();

            if (_quit.Pressed())
                Exit();

            // TODO: Add your update logic here

            InputHelper.UpdateCleanup();
            base.Update(gameTime);
        }

        protected override void Draw(GameTime gameTime) {
            GraphicsDevice.Clear(Color.Black);

            _s.Begin(effect: Assets.Linear);
            _s.Draw(Assets.Square, new Rectangle(100, 100, 400, 400), Color.White);
            _s.End();

            _s.Begin(effect: Assets.Expo);
            _s.Draw(Assets.Square, new Rectangle(800, 100, 800, 800), Color.White);
            _s.End();

            base.Draw(gameTime);
        }

        GraphicsDeviceManager _graphics;
        SpriteBatch _s;

        ICondition _quit =
            new AnyCondition(
                new KeyboardCondition(Keys.Escape),
                new GamePadCondition(GamePadButton.Back, 0)
            );
    }
}

# ORC
### Odin Reactive Components

ORC is meant to be a solution to the endless hellscape that is frontend development. Its main goal is to be an option for Odin developers to build reactive web applications using their favorite language. Write simple Odin code and watch as it renders in the browser.

## Why ORC?

**No More JavaScript Fatigue**
- Stop juggling dozens of dependencies that break with every update
- No more choosing between React, Vue, Svelte, or the framework-of-the-week
- Zero configuration hell - everything will work out of the box

**Performance by Default**
- Will compile directly to WebAssembly for native-like speed
- No virtual DOM overhead or JavaScript runtime bloat
- Smaller bundle sizes, faster load times

**Odin's Simplicity**
- Leverage Odin's clean syntax and powerful type system
- Write maintainable code without TypeScript's complexity
- Systems programming mindset applied to web development

## ORC's Goals

- Provide Odin developers a simple option for building web applications without JavaScript/TypeScript
- Compile directly to WebAssembly for maximum performance
- Include everything: bundler, server, components, routing - no configuration required
- Leverage Odin's simplicity and speed for web development
- Enable full-stack development in a single language

## Architecture

ORC is being designed as a complete ecosystem with integrated tools:

### Core Components
- **ORC Transpiler** - Transpiles `.orc` files to pure Odin code
- **ORC Compiler** - Compiles the now transpiled Odin code to WebAssembly
- **ORC Bundler** - Handles asset bundling, optimization, and code splitting
- **ORC Server** - Built-in HTTP server with WebSocket support for development and production
- **ORC Components** - Pre-built UI components and reactive system
- **ORC CLI** - Command-line tools for project scaffolding, building, and deployment

### File Structure
ORC applications are built using `.orc` files that combine Odin logic with declarative markup:
- Odin code sections handle application logic and state management
- ORC markup sections define the user interface using familiar HTML-like syntax
- Components can be composed and reused across an application
- `main.orc` serves as the application entry point

## Features

### Component System
- Reactive components with built-in state management
- Props-based component communication
- Lifecycle methods for component initialization and cleanup
- Built-in components for common UI patterns

### Development Experience
- Hot reload during development
- Integrated development server
- Built-in testing framework
- Rich error messages and debugging support

### Production Ready
- Optimized WebAssembly output
- Server-side rendering support
- Static site generation
- Multiple deployment targets

## Project Status

⚠️ **Early Development** - ORC is currently in the design and planning phase. The syntax and APIs are subject to change.

## Getting Started

*Documentation and installation instructions will be available once the initial implementation is complete.*

## Contributing

ORC is an open-source project and contributions are welcome! Whether you're interested in:
- Core framework development
- Built-in component library
- Documentation and examples
- Testing and bug reports

Please check back as the project develops for contribution guidelines.

## Roadmap

### Phase 1: Core Foundation
- [In Progress] Define and implement `.orc` file syntax
- [In Progress] Build transpiler (ORC → Odin)
- [ ] Build compiler (Odin → WASM)
- [ ] Basic component system
- [ ] CLI tooling

### Phase 2: Development Tools
- [ ] Bundler implementation
- [ ] Development server with hot reload
- [ ] Basic built-in components

### Phase 3: Production Features
- [ ] HTTP server integration
- [ ] Server-side rendering
- [ ] Performance optimizations
- [ ] Deployment tooling

### Phase 4: Ecosystem
- [ ] Extended component library
- [ ] Testing framework
- [ ] Plugin system
- [ ] Community tools

## License

Apache 2.0

